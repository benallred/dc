# dc

A `docker compose` wrapper with some added niceties.

Who wants to type `docker compose` when they could type `dc` instead? Shouldn't `docker compose up` do `-d` or `--wait` by default? Why doesn't `docker compose` have a `restart` command[^1]?

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

[^1]: I'm pretty sure `docker compose` didn't have a `restart` command when I created the first version of `dc` many years ago. It does now. I'm open to renaming `restart` in this wrapper (so as not to hide `docker compose restart`) if a good alternative is suggested.
