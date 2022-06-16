function dc(
    [string]$Command,
    [Parameter(ValueFromRemainingArguments = $true)]$Rest) {

    $totalTime = [System.Diagnostics.Stopwatch]::StartNew()

    if (!(Get-Process "Docker Desktop" -ErrorAction Ignore)) {
        if ($Command -eq "down") {
            Write-Output "Docker is not running"
            return
        }
        $startupTime = [System.Diagnostics.Stopwatch]::StartNew()
        . "$env:ProgramFiles\Docker\Docker\Docker Desktop.exe"
        while ((docker ps *>&1) -ilike "*error*") {
            Write-Output "Waiting for Docker Desktop to start"
            Start-Sleep -s 1
        }
        $startupTime.Stop()
        Write-Output "Time spent starting Docker Desktop: $($startupTime.Elapsed)"
    }

    $noWait = $Rest | ? { $_ -eq "--no-wait" }
    $Rest = $Rest | ? { $_ -ne "--no-wait" }

    switch ($Command) {
        "up" {
            dc up-without-wait $Rest
            if (!$noWait) {
                dc wait $Rest
            }
        }
        "up-without-wait" {
            docker compose up -d $Rest
        }
        "wait" {
            $progressReportInterval = 10
            $waitedSeconds = 0
            do {
                $waitingFor = docker compose ps -a --format json | ConvertFrom-Json | ? { $_.State -notin @("running", "exited") -or $_.Health -notin @("", "healthy") }
                if ($waitingFor) {
                    if (!$waitedSeconds) {
                        Write-Host "Waiting for these services to start and report healthy" -NoNewline
                    }
                    if ($waitedSeconds % $progressReportInterval -eq 0) {
                        Write-Host
                        $waitingFor | % {
                            $health = $_.Health -ne "" ? " ($($_.Health))" : ""
                            Write-Host "`t$($_.Name): $($_.State)$health"
                        }
                    }
                    else {
                        if ($waitedSeconds % $progressReportInterval -eq 1) {
                            Write-Host "`t" -NoNewline
                        }
                        Write-Host "." -NoNewline
                    }
                    Start-Sleep -s 1
                    $waitedSeconds++
                }
            }
            while ($waitingFor)

            if ($waitedSeconds) {
                Write-Host
            }
        }
        "restart" {
            dc down $Rest
            dc up $noWait $Rest
        }
        default {
            docker compose $Command $Rest
        }
    }

    Write-Output "Total time in ${Command}: $($totalTime.Elapsed)"
}
