# AI Coding Agent Instructions: HouseFlipperAE

## Project Overview

This is a **7 Days to Die modpack** - a curated collection of 16 compatible mods designed for building-focused gameplay. The project bridges mod authors, ModLauncherV5 (distribution platform), and end users through GitHub-based hosting.

## Architecture

**Distribution Model**: GitHub repository as mod server
- ModLauncherV5 downloads directly from `/Mods/` folder via `DownloadMode: GitHub`
- No ZIP files - all mods are pre-extracted folder structures
- Large assets (>100MB) hosted on GitHub Releases, downloaded via post-install script
- Single XML file (`modlauncherconfiguration.xml`) defines the modpack

**Critical Constraint**: **NO Git LFS** - ModLauncherV5 downloads LFS pointer files instead of actual assets. Use GitHub Releases for large files.

**File Structure**:
```
HouseFlipperAE/
├── Mods/                          # Extracted mod folders (load order via prefixes)
│   ├── 00000-Gears/               # UI framework (loads FIRST)
│   ├── 00000-Quartz/              # UI framework (depends on Gears)
│   ├── 00001-SMXcore/             # SMX UI core
│   ├── 00001-zSMXhud/             # SMX minimap/HUD
│   ├── 1_LittleRedSonja_UBBI_V2/  # Building/decor mod
│   └── 999_Compatibility_Patch/   # Compatibility fixes (loads LAST)
├── modlauncherconfiguration.xml   # ModLauncher definition
├── post_install_assets.bat        # User-friendly asset downloader
├── post_install_assets.ps1        # PowerShell download script
├── README.md                      # User documentation
├── DEVELOPMENT_GUIDE.md           # Developer workflow guide
├── TROUBLESHOOTING.md             # Common issues & fixes
└── CONTEXT.md                     # Design philosophy
```

## Critical Patterns

### 1. Load Order System

Mods load **alphabetically** - numeric prefixes enforce dependencies:

**Strict ordering**:
- `00000-` → Critical UI frameworks (Gears, Quartz) - MUST load first
- `00001-` → UI implementations (SMX suite) - depend on frameworks
- `0_` → Core dependencies (Harmony patches)
- `001-` → Gameplay modifiers (trader changes)
- `01-`, `1-` → Content mods (prefabs, vehicles, building blocks)
- `3-8-` → Quality of life (storage, sorting, terrain tools)
- `999-` → Compatibility patches - MUST load last

**Critical dependency**: If Quartz loads before Gears, UI breaks. Prefixes prevent this.

### 2. 7DTD V2.4 Mod Structure Requirements

**Mandatory structure** for DLL-based mods:
```
ModName/
├── Assemblies/           # DLLs MUST be here (V2.4 requirement)
│   ├── ModName.dll
│   └── Dependencies.dll
├── Config/               # XML configurations
│   ├── blocks.xml
│   ├── items.xml
│   └── recipes.xml
├── Resources/            # Assets (textures, prefabs, bundles)
└── ModInfo.xml           # Mod metadata (V2 format required)
```

**V2.4 ModInfo.xml format** (breaking change from V1):
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xml>
    <Name value="ModUniqueName"/>
    <DisplayName value="Display Name"/>
    <Version value="1.0.0"/>
    <Description value="Mod description"/>
    <Author value="Author Name"/>
    <Website value="https://example.com"/>
</xml>
```

**Old V1 format will cause load failures**.

### 3. ModLauncherV5 Integration

The `modlauncherconfiguration.xml` defines how ModLauncher installs the modpack:

```xml
<DownloadMode>GitHub</DownloadMode>
<Downloads>
  <Download>https://github.com/Midknightloki/HouseFlipperAE</Download>
</Downloads>
```

**How it works**:
1. ModLauncher clones/downloads entire repository
2. Extracts `/Mods/` folder to user's game directory
3. Respects numeric prefixes for load order
4. User must run `post_install_assets.bat` for large files

**Distribution URL**: Users add `https://raw.githubusercontent.com/Midknightloki/HouseFlipperAE/main/modlauncherconfiguration.xml` to ModLauncher.

### 4. Large Asset Workaround

GitHub repository size limit: **Files >100MB cannot be committed**

**Solution pattern** (LittleRedSonja 305MB unity3d bundle):
1. Host file on **GitHub Releases** as downloadable asset
2. Provide `post_install_assets.bat` wrapper that calls PowerShell script
3. PowerShell script downloads from releases and places in correct mod folder
4. Check file size to detect corrupted downloads (re-download if <100MB)

```powershell
$assetUrl = "https://github.com/.../releases/download/v2.0.0/SonjaUBBI.unity3d"
$assetPath = "Mods/1_LittleRedSonja_ZT_UBBI_V2/Resources/SonjaUBBI.unity3d"
Invoke-WebRequest -Uri $assetUrl -OutFile $assetPath
```

**User workflow**: Install via ModLauncher → Double-click `post_install_assets.bat` → Done

## Common Tasks

### Adding a New Mod

1. **Test compatibility locally first**:
   - Copy mod to `F:\7D2D\v2\House_Flipper_-_Apocalypse_Edition\Mods\`
   - Launch game, check console (F1) for errors
   - Test mod functionality thoroughly
   - Check `output_log.txt` for warnings

2. **Determine load order**:
   - UI frameworks → prefix `00000-`
   - UI implementations → prefix `00001-`
   - Core mechanics → prefix `0-` or `001-`
   - Content/building → prefix `01-` or `1-`
   - QoL → prefix `3-8-`
   - Compatibility → prefix `999-`

3. **Verify V2.4 structure**:
   ```bash
   # Check DLLs are in Assemblies/
   ls -R ModName/ | Select-String "\.dll"
   # Verify ModInfo.xml format
   cat ModName/ModInfo.xml | Select-String "<Name value="
   ```

4. **Add to repository**:
   - Rename folder with load order prefix: `8_ModName/`
   - Copy to `HouseFlipperAE/Mods/`
   - If files >100MB: Extract to Releases, update post_install script
   - Update README.md mod list with version

5. **Update documentation**:
   - Add to README.md → Mod List section
   - Update CHANGELOG with addition
   - Increment version in `modlauncherconfiguration.xml`

### Removing a Mod

1. **Check dependencies**:
   ```bash
   # Search for references in other mods' XML
   grep -r "ModNameToRemove" Mods/*/Config/
   ```

2. **Delete folder**: `rm -rf Mods/XX_ModName/`

3. **Update docs**: Remove from README.md, add to CHANGELOG

4. **Test clean install**: Delete local test mods folder, reinstall via ModLauncher

### Updating an Existing Mod

1. **Download new version** from mod author
2. **Backup current version**: `cp -r Mods/1_ModName/ ../backups/`
3. **Replace mod folder** maintaining same prefix
4. **Verify structure** (DLLs in Assemblies/, V2 ModInfo.xml)
5. **Test locally** - compare `output_log.txt` before/after
6. **Update version** in README.md and CHANGELOG
7. **Commit with clear message**: `"Update ModName from v1.0 to v1.1"`

### Creating Compatibility Patch

When two mods conflict (e.g., both modify same loot container):

1. **Create patch mod**:
   ```
   Mods/999_Compatibility_Patch/
   ├── Config/
   │   └── loot.xml
   └── ModInfo.xml
   ```

2. **Use append xpath** to merge changes:
   ```xml
   <append xpath="/lootcontainers/lootcontainer[@id='conflictedContainer']">
       <item name="additionalItem" count="1"/>
   </append>
   ```

3. **Prefix `999-`** to ensure it loads last and overrides conflicts

## Testing Workflow

### Local Single-Player Test

1. **Clean test environment**:
   ```powershell
   rm -rf "F:\7D2D\v2\House_Flipper_-_Apocalypse_Edition\Mods\*"
   cp -r HouseFlipperAE\Mods\* "F:\7D2D\v2\House_Flipper_-_Apocalypse_Edition\Mods\"
   ```

2. **Launch game** → F1 console → Check for errors

3. **Create NEW world** (existing worlds cache old settings)

4. **Test checklist**:
   - [ ] All mods appear in mod list (F1 → Mods tab)
   - [ ] No red errors in console
   - [ ] Custom items craftable/accessible
   - [ ] UI changes work (Gears menu, SMX minimap)
   - [ ] No missing texture warnings

5. **Review log file**:
   ```powershell
   Select-String -Path "7DaysToDie_Data\output_log.txt" -Pattern "ERR " -Context 2,2
   ```

### Server Testing

**Critical**: Server mods must support multiplayer - some client-only mods break servers.

1. **Setup dedicated server**:
   ```bash
   # Install 7D2D dedicated server via SteamCMD
   ./steamcmd.sh +login anonymous +app_update 294420 validate +quit
   ```

2. **Copy modpack**: `cp -r HouseFlipperAE/Mods/* <server>/Mods/`

3. **Configure `serverconfig.xml`**:
   ```xml
   <property name="BloodMoonFrequency" value="0"/>
   <property name="EACEnabled" value="false"/>
   ```

4. **Start server** → Monitor logs for errors

5. **Client test**: Connect from game client → Verify mods sync

### Common Error Patterns

**"ERR LootContainer 'X' unknown"**:
- Cause: Mod removed vanilla loot definition
- Fix: Create 999_Compatibility_Patch to restore definition

**"ERR Could not load 'ModName' DLL"**:
- Cause: DLL not in `Assemblies/` folder
- Fix: Move DLL from root to `ModName/Assemblies/`

**"ERR ModInfo.xml parse error"**:
- Cause: Using old V1 format instead of V2
- Fix: Convert to `<Name value="X"/>` format

**"WRN AssetBundle from V1"**:
- Cause: Asset bundle built for older Unity version
- Impact: Non-critical, can ignore (usually works anyway)

## Version Management

### Version Bump Checklist

When releasing new modpack version:

1. ✅ Update `modlauncherconfiguration.xml`:
   ```xml
   <Version>2.1.0</Version>
   <ReleaseNotes>Version 2.1.0 - Added XYZ mod...</ReleaseNotes>
   ```

2. ✅ Update README.md:
   - Header version number
   - Mod list if changed
   - Installation instructions if process changed

3. ✅ Create CHANGELOG.md entry at top

4. ✅ Git tag release:
   ```bash
   git tag -a v2.1.0 -m "Release v2.1.0"
   git push origin v2.1.0
   ```

5. ✅ **If large assets changed**: Upload to GitHub Releases → Update post_install script URLs

6. ✅ Test clean install via ModLauncher

### Semantic Versioning

- **Major (X.0.0)**: Breaking changes (remove mods, require new world)
- **Minor (2.X.0)**: Add/update mods (compatible with existing worlds)
- **Patch (2.1.X)**: Bug fixes, documentation updates

## Troubleshooting Framework

### Installation Issues

**Symptom: ModLauncher won't download modpack**
- **Cause**: XML URL incorrect or GitHub repo not public
- **Fix**: Verify raw URL points to `main` branch: `https://raw.githubusercontent.com/.../main/modlauncherconfiguration.xml`
- **Test**: Open URL in browser - should show raw XML

**Symptom: Large assets missing (LittleRedSonja items absent)**
- **Cause**: User didn't run post-install script
- **Fix**: Instruct user to double-click `post_install_assets.bat`
- **Verify**: Check file exists and is >100MB: `Mods/1_LittleRedSonja_ZT_UBBI_V2/Resources/SonjaUBBI.unity3d`

**Symptom: Mods not loading after installation**
- **Cause**: Folder structure wrong or ModInfo.xml malformed
- **Fix**: Each mod folder must contain `ModInfo.xml` at root
- **Check load order**: Prefixes enforce sequence - verify no duplicate prefixes

### Gameplay Issues

**Symptom: Horde nights still occurring**
- **Cause**: Existing world has cached settings
- **Fix**: Create NEW world OR edit `serverconfig.xml`:
  ```xml
  <property name="BloodMoonFrequency" value="0"/>
  ```

**Symptom: UI mods not working (no Gears menu, missing minimap)**
- **Cause**: Load order violation (Quartz loaded before Gears)
- **Fix**: Verify prefixes: `00000-Gears/` and `00000-Quartz/` both exist
- **Alternative cause**: DLLs not in `Assemblies/` - check structure

**Symptom: Missing building blocks/items**
- **Cause**: Mod not loaded or asset bundle missing
- **Fix**: Check mod appears in F1 → Mods list
- **If missing**: Run post-install script for large assets

### Conflict Resolution

**Two mods modify same XML element**:
1. Identify conflict via error logs
2. Create `999_Compatibility_Patch/Config/<file>.xml`
3. Use append xpath to merge both modifications
4. Test to verify both mods' features work

**DLL conflicts** (rare):
- Check for duplicate assembly names
- Contact mod authors - usually requires one mod to be removed
- Document incompatibility in README.md

## Development Best Practices

### XML Editing Patterns

**Good - Append preserves other mods**:
```xml
<append xpath="/recipes">
    <recipe name="newRecipe" count="1">...</recipe>
</append>
```

**Bad - Set/Replace overwrites everything**:
```xml
<set xpath="/recipes">
    <recipe name="newRecipe" count="1">...</recipe>
</set>
```

### Git Workflow

**Branch strategy**: Single `main` branch (ModLauncher points to `main`)

**Commit messages**:
- `feat: Add ModName v1.0` - New mod
- `update: ModName v1.0 → v1.1` - Mod version bump
- `fix: Resolve loot container conflict` - Bug fix
- `docs: Update troubleshooting guide` - Documentation

**Never commit**:
- Files >100MB (use Releases instead)
- Git LFS tracked files (ModLauncher can't handle them)
- Test installations or backups (`scripts/` folder is gitignored)

### Documentation Standards

**README.md** - User-facing:
- Installation steps (non-technical users)
- Mod list with versions
- Basic troubleshooting

**DEVELOPMENT_GUIDE.md** - Developer-facing:
- Technical workflows
- Testing procedures
- Repository management

**TROUBLESHOOTING.md** - Support-focused:
- Symptom → Cause → Solution format
- Organized by problem category
- Common error messages with fixes

## Quick Reference

### Load Order Prefix Cheat Sheet

| Prefix | Category | Examples |
|--------|----------|----------|
| `00000-` | Critical UI frameworks | Gears, Quartz |
| `00001-` | UI implementations | SMXcore, SMXhud |
| `0_` | Core patches | TFP_Harmony |
| `001-` | Gameplay modifiers | No trader rekt |
| `01-`, `1-` | Content/building | MPLogue, LittleRedSonja, Vehicles |
| `3-8-` | QoL & decoration | PyroPaints, BeyondStorage, Sorters |
| `999-` | Compatibility patches | Must load last |

### Essential PowerShell Commands

```powershell
# Search for errors in logs
Select-String -Path "output_log.txt" -Pattern "ERR " -Context 2,2

# Find mod references
grep -r "ModName" Mods/*/Config/

# Check DLL locations
Get-ChildItem -Recurse Mods/ -Filter "*.dll" | Select-Object FullName

# Test post-install script
.\post_install_assets.ps1

# Verify mod structure
ls -R Mods/ModName/ | Select-String "ModInfo.xml|Assemblies|Config"
```

### ModInfo.xml V2 Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xml>
    <Name value="UniqueModID"/>
    <DisplayName value="User-Facing Name"/>
    <Version value="1.0.0"/>
    <Description value="Brief description of mod features"/>
    <Author value="Original Author"/>
    <Website value="https://mod-homepage.com"/>
</xml>
```

### New Mod Addition Checklist

1. ✅ Test mod locally in clean installation
2. ✅ Verify V2.4 compatibility (DLLs in Assemblies/, V2 ModInfo.xml)
3. ✅ Determine load order prefix based on dependencies
4. ✅ Check file sizes (<100MB or use Releases)
5. ✅ Copy to `Mods/XX_ModName/` with prefix
6. ✅ Update README.md mod list
7. ✅ Update CHANGELOG.md
8. ✅ Increment version in modlauncherconfiguration.xml
9. ✅ Test via ModLauncher clean install
10. ✅ Commit with descriptive message
