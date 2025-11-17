@echo off
REM Post-Install Asset Downloader for House Flipper AE
REM Double-click this file to download large assets

echo.
echo ========================================================
echo House Flipper AE - Post-Install Asset Download
echo ========================================================
echo.

REM Check if PowerShell is available
where powershell >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: PowerShell is not installed or not in PATH
    echo Please install PowerShell or run post_install_assets.ps1 manually
    pause
    exit /b 1
)

REM Run the PowerShell script with execution policy bypass
echo Running asset download script...
echo.
powershell -ExecutionPolicy Bypass -File "%~dp0post_install_assets.ps1"

REM Check if script succeeded
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================================
    echo Success! Asset download complete.
    echo You can now close this window and launch the game.
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo Download failed or was cancelled.
    echo Please check the error messages above.
    echo ========================================================
)

echo.
pause
