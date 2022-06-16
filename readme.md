# dc

A `docker compose` wrapper with some added niceties.

Who wants to type `docker compose` when they could type `dc` instead? Shouldn't `docker compose up` do `-d` or `--wait` by default? Why doesn't `docker compose` have a `restart` command?

## Installation

```powershell
git clone https://github.com/benallred/dc.git
Add-Content -Path $profile -Value "`n. $pwd\dc\dc.ps1"
. $profile
```

## Usage examples

```powershell
dc up

dc restart

dc down

dc up --no-wait

dc <any `docker compose` command>
```
