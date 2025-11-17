# Post-Install Script for House Flipper AE
# Downloads large assets that exceed GitHub repository limits

$ErrorActionPreference = "Stop"

Write-Host "House Flipper AE - Post-Install Asset Download" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Large asset: LittleRedSonja UBBI
$assetUrl = "https://github.com/Midknightloki/HouseFlipperAE/releases/download/v2.0.0/SonjaUBBI.unity3d"
$assetPath = "Mods/1_LittleRedSonja_ZT_UBBI_V2/Resources/SonjaUBBI.unity3d"

if (Test-Path $assetPath) {
    Write-Host "✓ SonjaUBBI.unity3d already exists, skipping download" -ForegroundColor Green
} else {
    Write-Host "Downloading SonjaUBBI.unity3d (305 MB)..." -ForegroundColor Yellow
    $dir = Split-Path $assetPath -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    try {
        Invoke-WebRequest -Uri $assetUrl -OutFile $assetPath -UseBasicParsing
        Write-Host "✓ Download complete!" -ForegroundColor Green
    } catch {
        Write-Host "✗ Download failed: $_" -ForegroundColor Red
        Write-Host "Please manually download from: $assetUrl" -ForegroundColor Yellow
        Write-Host "And place it at: $assetPath" -ForegroundColor Yellow
    }
}

Write-Host "`nPost-install complete!" -ForegroundColor Green
