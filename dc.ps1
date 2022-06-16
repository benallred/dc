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
            docker compose up -d ($noWait ? "" : "--wait") $Rest
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
