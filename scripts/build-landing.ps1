param(
  [string]$LicensingUrl = $env:LICENSING_URL,
  [string]$ReleaseVersion = $env:RELEASE_VERSION,
  [string]$ReleaseDownloadUrl = $env:RELEASE_DOWNLOAD_URL,
  [string]$SupportEmail = $env:SUPPORT_EMAIL
)

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if (-not $LicensingUrl) { $LicensingUrl = 'https://licencias.mello.com.ar/?from=landing' }
if (-not $ReleaseVersion) { $ReleaseVersion = '2.3.0' }
if (-not $ReleaseDownloadUrl) { $ReleaseDownloadUrl = 'https://github.com/mellomda3/puntonexo-releases/releases/download/v2.3.0/PuntoNexo-Installer-2.3.0.exe' }
if (-not $SupportEmail) { $SupportEmail = 'soporte@mello.com.ar' }

$content = @"
window.PN_CONFIG = {
  licensingUrl: '$($LicensingUrl -replace "'","\\'")',
  releaseVersion: '$($ReleaseVersion -replace "'","\\'")',
  releaseDownloadUrl: '$($ReleaseDownloadUrl -replace "'","\\'")',
  supportEmail: '$($SupportEmail -replace "'","\\'")'
};
"@

Set-Content -Path (Join-Path $root 'config.js') -Value $content -Encoding UTF8
Write-Host "Generated config.js"

