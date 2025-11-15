param(
    [Parameter(Mandatory=$true)][string]$Owner,
    [Parameter(Mandatory=$true)][string]$Repo,
    [Parameter(Mandatory=$true)][string]$Tag,
    [string]$ModsPath = "F:\\HouseFlipperAE\\Mods",
    [string]$Output = "F:\\HouseFlipperAE\\v2\\HouseFlipper_Modpack.xml",
    [string]$PackName = "House Flipper: Apocalypse Edition",
    [string]$Author = "Loki Midknight",
    [string]$Version = "1.0.0",
    [string]$GameVersion = "2.4 b7"
)

Write-Host "Generating modpack XML for GitHub release downloads..."

if (-not (Test-Path $ModsPath)) {
    Write-Error "Mods path '$ModsPath' does not exist."
    exit 1
}

$files = Get-ChildItem -Path $ModsPath -File | Where-Object { $_.Extension -in '.zip','.7z','.rar' }

if ($files.Count -eq 0) {
    Write-Warning "No archive files found in $ModsPath. The XML will only include the pack header."
}

$modlets = ""
foreach ($f in $files) {
    $fileName = $f.Name
    $safeName = $fileName -replace '&','&amp;'
    $url = "https://github.com/$Owner/$Repo/releases/download/$Tag/$fileName"
    $modlets += ("    <modlet name='{0}' modtype='Modlet' url='{1}' />`n" -f $safeName, $url)
}

$xml = @"
<?xml version="1.0" encoding="utf-8"?>
<modpack>
    <pack
        name="$PackName"
        author="$Author"
        description="The custom overhaul pack for my server. Don't break it!"
        version="$Version"
        gameversion="$GameVersion"
    />

$modlets
</modpack>
"@

[IO.File]::WriteAllText($Output, $xml)
Write-Host "Wrote manifest to $Output"
Write-Host "Next: upload each file in '$ModsPath' to the GitHub release '$Tag' for '$Owner/$Repo' (see README below)."
