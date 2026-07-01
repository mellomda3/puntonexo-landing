# Sincroniza dev/cursor (PuntoNexo-Dev) → C:\Projects\puntonexo-landing → GitHub main.
# Mismo patrón que SuperMarketTPV/scripts/sync-to-github.ps1
#
# Uso:
#   cd C:\Users\mello\Projects\PuntoNexo-Dev\puntonexo-landing
#   .\scripts\sync-to-github.ps1
#   .\scripts\sync-to-github.ps1 -MergeMessage "chore: landing v2.2.6"

param(
    [string]$MergeMessage = "merge: dev/cursor"
)

$ErrorActionPreference = "Stop"
$DevRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
if ($env:PUNTONEXO_DEV_ROOT) {
    $envRoot = Join-Path $env:PUNTONEXO_DEV_ROOT "puntonexo-landing"
    if ((Test-Path $envRoot) -and (Test-Path (Join-Path $envRoot ".git"))) {
        $DevRoot = (Resolve-Path $envRoot).Path
    } else {
        Write-Warning "PUNTONEXO_DEV_ROOT no apunta a puntonexo-landing valido; usando repo del script."
    }
}
$ProjectsRoot = "C:\Projects\puntonexo-landing"

function Invoke-GitQuiet {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$GitArgs)
    $prev = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        & git @GitArgs 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "git $($GitArgs -join ' ') falló (exit $LASTEXITCODE)"
        }
    }
    finally {
        $ErrorActionPreference = $prev
    }
}

function Sync-Branches {
    param([string]$Message)

    Push-Location $DevRoot
    try {
        $branch = git branch --show-current
        if ($branch -ne "dev/cursor") {
            throw "Ejecutar desde la rama dev/cursor (actual: $branch)."
        }
        Write-Host ">> Push dev/cursor → C:\Projects\puntonexo-landing" -ForegroundColor Cyan
        Invoke-GitQuiet push --no-verify origin dev/cursor:dev/cursor
    }
    finally {
        Pop-Location
    }

    Push-Location $ProjectsRoot
    try {
        Write-Host ">> Merge dev/cursor → main" -ForegroundColor Cyan
        Invoke-GitQuiet checkout main
        Invoke-GitQuiet merge dev/cursor -m $Message
        Write-Host ">> Push main → GitHub" -ForegroundColor Cyan
        Invoke-GitQuiet push origin main
        return (git rev-parse --short HEAD).Trim()
    }
    finally {
        Pop-Location
    }
}

Push-Location $DevRoot
try {
    if (git status --porcelain) {
        throw "Hay cambios sin commitear en PuntoNexo-Dev\puntonexo-landing."
    }
}
finally {
    Pop-Location
}

$hash = Sync-Branches -Message $MergeMessage
Write-Host "OK: $hash en GitHub main (landing)" -ForegroundColor Green
Write-Host "  https://puntonexo.mello.com.ar/" -ForegroundColor White
Write-Host "  https://github.com/mellomda3/puntonexo-landing" -ForegroundColor White
