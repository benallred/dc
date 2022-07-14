# dc

A `docker compose` wrapper with some added niceties.

Who wants to type `docker compose` when they could type `dc` instead? Shouldn't `docker compose up` do `-d` or `--wait` by default? Why doesn't `docker compose` have a single command to start over completely?

## Installation

`dc` requires PowerShell 7 or greater.[^1][^2]

```powershell
git clone https://github.com/benallred/dc.git
if (!(Test-Path $profile)) { New-Item $profile -Force }
Add-Content -Path $profile -Value "`n. $pwd\dc\dc.ps1"
. $profile
```

## Updating

```powershell
cd dc
git pull
```

## Usage examples

```powershell
dc up

dc reup

dc down

dc up --no-wait

dc <any `docker compose` command or argument>
```

[^1]: If you really want it in Windows PowerShell (v5), file an issue. It's an easy change. But PowerShell 7 gives us the ternary operator and I'm going to use it until someone really needs this in Windows PowerShell.
[^2]: Installing the latest PowerShell is easy. You have a few options:

    1. (Recommended) `winget install Microsoft.PowerShell` (run in Windows PowerShell)
    2. (Alternative) [Install from the Microsoft Store](https://apps.microsoft.com/store/detail/powershell/9MZ1SNWT0N5D)
    3. (Alternative) [Install from GitHub](https://github.com/PowerShell/PowerShell#get-powershell)
    4. (Alternative) [Other methods](https://aka.ms/PSWindows)
