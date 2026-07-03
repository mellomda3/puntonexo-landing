# Fuerza un rebuild de GitHub Pages cuando el workflow "pages build and deployment"
# falla con "Deployment failed, try again later" (build OK, deploy atascado).
#
# Uso:
#   .\scripts\rebuild-pages.ps1
#   .\scripts\rebuild-pages.ps1 -Repo mellomda3/puntonexo-landing

param(
    [string]$Repo = "mellomda3/puntonexo-landing"
)

$ErrorActionPreference = "Stop"

Write-Host "Solicitando rebuild de Pages en $Repo..." -ForegroundColor Cyan
gh api -X POST "repos/$Repo/pages/builds" | Out-Null

Start-Sleep -Seconds 5
$latest = gh api "repos/$Repo/pages/builds/latest" --jq '{status, commit: .commit[0:7], error: .error.message}' 2>$null
if ($latest) {
    Write-Host "Estado: $latest" -ForegroundColor Green
} else {
    Write-Host "Rebuild encolado. Ver: https://github.com/$Repo/actions" -ForegroundColor Green
}

Write-Host "Sitio: https://puntonexo.mello.com.ar/" -ForegroundColor White
