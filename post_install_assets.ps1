# Post-Install Script for House Flipper AE
# Downloads large assets that exceed GitHub repository limits

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "House Flipper AE - Post-Install Asset Download" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Large asset: LittleRedSonja UBBI
$assetUrl = "https://github.com/Midknightloki/HouseFlipperAE/releases/download/v2.0.0/SonjaUBBI.unity3d"
$assetPath = "Mods/1_LittleRedSonja_ZT_UBBI_V2/Resources/SonjaUBBI.unity3d"

if (Test-Path $assetPath) {
    $fileSize = (Get-Item $assetPath).Length / 1MB
    if ($fileSize -gt 100) {
        $sizeRounded = [math]::Round($fileSize, 2)
        Write-Host "Success: SonjaUBBI.unity3d already exists ($sizeRounded MB), skipping download" -ForegroundColor Green
        Write-Host ""
        Write-Host "Post-install complete!" -ForegroundColor Green
        exit 0
    } else {
        $sizeRounded = [math]::Round($fileSize, 2)
        Write-Host "Warning: Found small or corrupted file ($sizeRounded MB), re-downloading..." -ForegroundColor Yellow
        Remove-Item $assetPath -Force
    }
}

Write-Host "Downloading SonjaUBBI.unity3d (approximately 305 MB)..." -ForegroundColor Yellow
Write-Host "This may take several minutes depending on your connection speed." -ForegroundColor Gray
Write-Host ""

$dir = Split-Path $assetPath -Parent
if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

try {
    Invoke-WebRequest -Uri $assetUrl -OutFile $assetPath -UseBasicParsing
    
    $finalSize = (Get-Item $assetPath).Length / 1MB
    $finalSizeRounded = [math]::Round($finalSize, 2)
    Write-Host ""
    Write-Host "Success: Download complete! ($finalSizeRounded MB)" -ForegroundColor Green
    
} catch {
    Write-Host ""
    Write-Host "Error: Download failed - $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual download instructions:" -ForegroundColor Yellow
    Write-Host "1. Download from: $assetUrl" -ForegroundColor Gray
    Write-Host "2. Place the file at: $assetPath" -ForegroundColor Gray
    Write-Host "3. Verify file size is approximately 305 MB" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "Post-install complete! You can now launch the game." -ForegroundColor Green
