# 7 Days to Die Modpack Development & Deployment Guide

**Last Updated**: November 23, 2025  
**Target**: 7 Days to Die V2.4 (1.0 Stable)  
**Project**: House Flipper: Apocalypse Edition

## Table of Contents
- [Development Workflow](#development-workflow)
- [Testing & Validation](#testing--validation)
- [Repository Management](#repository-management)
- [Deployment Process](#deployment-process)
- [Server Setup](#server-setup)
- [Troubleshooting Common Issues](#troubleshooting-common-issues)
- [Best Practices](#best-practices)

---

## Development Workflow

### 1. Setting Up Your Development Environment

#### Directory Structure
```
F:\7D2D\v2\
├── House_Flipper_-_Apocalypse_Edition\  (Active test installation)
│   └── Mods\                             (Testing environment)
├── HouseFlipperAE\                       (Git repository)
│   ├── Mods\                             (Source of truth)
│   ├── scripts\                          (Developer tools - gitignored)
│   ├── Server\                           (Mod archives)
│   ├── v2\                               (Documentation)
│   ├── post_install_assets.bat           (User-friendly installer)
│   ├── post_install_assets.ps1           (PowerShell download script)
│   ├── modlauncherconfiguration.xml      (ModLauncher config)
│   └── README.md
```

#### Initial Setup
1. **Install 7D2D V2.4** - Ensure you have a clean installation
2. **Clone Repository**:
   ```powershell
   git clone git@github.com:Midknightloki/HouseFlipperAE.git
   cd HouseFlipperAE
   ```
3. **Configure SSH Keys** (for push access):
   ```powershell
   .\scripts\setup_ssh_keys.ps1
   ```

### 2. Adding New Mods

#### Process
1. **Download & Extract** mod to `Mods/Server/` directory
2. **Test Locally** - Copy to test installation first
3. **Verify Compatibility**:
   - Check for V2.4 compatibility
   - Test for conflicts with existing mods
   - Review load order requirements
4. **Rename for Load Order** (if needed):
   - `00000-` = Critical UI framework (Gears, Quartz)
   - `00001-` = UI mods (SMX suite)
   - `001-` = Gameplay modifiers
   - `01-1-` = Building/content mods
   - `3-8-` = QoL and decoration
   - `999-` = Compatibility patches (load last)

#### Critical Considerations

**V2.4 DLL Requirement**:
- All mod DLLs MUST be in `Assemblies/` subfolder
- Example structure:
  ```
  Mods/00000-Gears/
  ├── Assemblies/
  │   ├── Gears.dll
  │   └── GearsAPI.dll
  ├── Config/
  └── ModInfo.xml
  ```

**ModInfo.xml Format**:
- V2.4 requires V2 format:
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <xml>
      <Name value="ModName"/>
      <DisplayName value="Mod Display Name"/>
      <Version value="1.0.0"/>
      <Description value="Mod description"/>
      <Author value="Author Name"/>
      <Website value="https://example.com"/>
  </xml>
  ```

### 3. Mod Configuration Best Practices

#### XML Editing
- **Use append xpath** instead of set to avoid breaking other mods:
  ```xml
  <!-- Good -->
  <append xpath="/lootcontainers">
      <lootcontainer id="myContainer">...</lootcontainer>
  </append>
  
  <!-- Bad - overwrites everything -->
  <set xpath="/lootcontainers">
      <lootcontainer id="myContainer">...</lootcontainer>
  </set>
  ```

#### Common Pitfalls
1. **Missing Vanilla Definitions**:
   - If overriding `loot.xml`, include ALL vanilla containers
   - Create compatibility patches to restore removed definitions
   
2. **Load Order Conflicts**:
   - UI frameworks must load first
   - Compatibility patches must load last
   
3. **Asset Bundle Issues**:
   - Files >100MB cannot be in Git repository
   - Use GitHub Releases for large assets
   - Provide download scripts for users

---

## Testing & Validation

### 1. Local Testing

#### Single Player Test
1. Copy mods to test installation
2. Launch game and create NEW world
3. Check for errors in console (F1)
4. Test mod features thoroughly
5. Review log file: `7DaysToDie_Data/output_log.txt`

#### Common Test Cases
- [ ] Game launches without crashes
- [ ] Mods appear in mod list
- [ ] Custom items/blocks are accessible
- [ ] UI changes work correctly
- [ ] No critical errors in logs
- [ ] All loot containers are lootable
- [ ] Custom vehicles/entities spawn correctly

### 2. Error Analysis

#### Log File Locations
- **Client**: `7DaysToDie_Data/output_log.txt`
- **Server**: `logs/latest.log`

#### Critical Errors to Watch For
```
ERR LootContainer 'X' unknown          → Missing loot definition
ERR Could not load 'X' DLL             → DLL not in Assemblies/ folder
ERR ModInfo.xml parse error            → Wrong XML format (need V2)
WRN AssetBundle from V1                → Non-critical, can ignore
```

#### Using PowerShell for Log Analysis
```powershell
# Search for errors
Select-String -Path "logs/latest.log" -Pattern "ERR " -Context 2,2

# Count specific error types
(Select-String -Path "logs/latest.log" -Pattern "ERR LootContainer").Count

# Find mod-specific errors
Select-String -Path "logs/latest.log" -Pattern "ModName" | Select-String "ERR|WRN"
```

### 3. Multiplayer/Server Testing

#### Test Server Setup
1. Install dedicated server
2. Copy modpack to server `Mods/` folder
3. Configure `serverconfig.xml`
4. Start server and monitor logs
5. Connect as client and test

#### Server-Specific Checks
- [ ] Server starts without crashes
- [ ] Clients can connect
- [ ] Mods sync to clients properly
- [ ] No desync issues
- [ ] Performance is acceptable
- [ ] Loot spawns correctly
- [ ] Custom POIs generate in RWG

---

## Repository Management

### 1. Git Configuration

#### Important: NO Git LFS!
ModLauncherV5 **does not support Git LFS**. It downloads pointer files instead of actual assets.

**Never commit with LFS**:
```powershell
# If LFS is accidentally enabled, disable it:
git lfs uninstall
Remove-Item .gitattributes
```

#### .gitignore Setup
The repository includes proper `.gitignore`:
- `scripts/` - Developer tools (not for end users)
- `*.zip`, `*.rar`, `*.7z` - Keep archives in `Mods/Server/` locally only
- Large files that need manual handling

### 2. Handling Large Files (>100MB)

#### Problem
GitHub has a 100MB file size limit. Some mod assets exceed this.

#### Solution Pattern
1. **Identify large files**:
   ```powershell
   Get-ChildItem -Recurse | Where-Object { $_.Length -gt 100MB } | 
       Select-Object Name, @{N='Size(MB)';E={[math]::Round($_.Length/1MB,2)}}
   ```

2. **Exclude from repository** - Don't commit them
3. **Create GitHub Release** with large file as asset
4. **Provide download script**:
   ```powershell
   # post_install_assets.ps1
   $assetUrl = "https://github.com/user/repo/releases/download/v1.0/largefile.unity3d"
   $assetPath = "Mods/ModName/Resources/largefile.unity3d"
   Invoke-WebRequest -Uri $assetUrl -OutFile $assetPath
   ```

5. **Create user-friendly batch wrapper**:
   ```batch
   @echo off
   powershell -ExecutionPolicy Bypass -File "%~dp0post_install_assets.ps1"
   pause
   ```

### 3. Commit Strategy

#### Atomic Commits
Make focused commits for specific changes:
```powershell
# Good
git add Mods/NewMod/
git commit -m "Add NewMod v1.2.3 for building enhancements"

# Bad - too many unrelated changes
git add -A
git commit -m "Various updates"
```

#### Commit Message Format
```
<Type>: <Short description>

<Detailed description if needed>
<Why the change was made>
<What was tested>
<Any breaking changes>
```

Types: Add, Fix, Update, Remove, Refactor, Docs

Example:
```
Fix: Restore missing birdNest loot container

Added 999_Compatibility_Patch mod to restore vanilla loot containers
that were removed when other mods override loot.xml.

Fixes: ERR LootContainer 'birdNest' unknown
Tested: Server restart, existing world compatible
```

### 4. Branching Strategy

#### Simple Workflow
- `main` - Production-ready releases
- `dev` - Active development (optional)
- Feature branches for major changes

```powershell
# Create feature branch
git checkout -b feature/new-ui-mod
# ... make changes ...
git commit -m "Add: New UI mod integration"
git push -u origin feature/new-ui-mod
# Create PR on GitHub, merge when tested
```

---

## Deployment Process

### 1. Preparing for Release

#### Pre-Release Checklist
- [ ] All mods tested in single player
- [ ] Server tested with multiple clients
- [ ] No critical errors in logs
- [ ] README.md updated with changes
- [ ] TROUBLESHOOTING.md updated if needed
- [ ] `v2/curated_mod_list.md` updated
- [ ] Version number incremented
- [ ] Large files handled (releases/scripts)

#### Version Numbering
Use semantic versioning: `MAJOR.MINOR.PATCH`
- MAJOR: Breaking changes, complete refactor
- MINOR: New mods, significant features
- PATCH: Bug fixes, small tweaks

Update in:
- `modlauncherconfiguration.xml` → `<Version>2.0.0</Version>`
- `README.md` → `**Version X.X.X**`

### 2. Creating GitHub Release

#### Process
1. **Tag the release**:
   ```powershell
   git tag -a v2.0.0 -m "Version 2.0.0: SMX UI integration and compatibility fixes"
   git push origin v2.0.0
   ```

2. **Create release on GitHub**:
   - Go to: `https://github.com/Midknightloki/HouseFlipperAE/releases/new`
   - Select tag: `v2.0.0`
   - Title: `House Flipper AE v2.0.0`
   - Description: Include changelog, breaking changes, installation notes
   - Upload large asset files (>100MB)
   - Publish release

3. **Update download URLs** in scripts if needed

### 3. ModLauncherV5 Configuration

#### modlauncherconfiguration.xml
Key elements:
```xml
<ModInfo>
    <Name value="House Flipper: Apocalypse Edition"/>
    <Description value="Detailed description"/>
    <Author value="HouseFlipperAE Team"/>
    <Version value="2.0.0"/>
    <Website value="https://github.com/Midknightloki/HouseFlipperAE"/>
</ModInfo>

<DownloadMode value="GitHub"/>
<GitHub_Repository value="Midknightloki/HouseFlipperAE"/>
<GitHub_Branch value="main"/>
<GitHub_ModsPath value="Mods"/>
```

#### Installation URL
Users install with:
```
https://raw.githubusercontent.com/Midknightloki/HouseFlipperAE/main/modlauncherconfiguration.xml
```

#### Validation
Test the ModLauncher installation:
1. Fresh 7D2D installation
2. Add custom mod URL in ModLauncherV5
3. Install and verify all files downloaded
4. Check for missing files/errors
5. Launch game and test

---

## Server Setup

### 1. Dedicated Server Installation

#### Linux Server (Recommended)
```bash
# Install SteamCMD
sudo apt-get update
sudo apt-get install steamcmd

# Install 7D2D Dedicated Server
steamcmd +login anonymous \
    +force_install_dir /home/container \
    +app_update 294420 validate \
    +quit
```

#### Windows Server
1. Download SteamCMD
2. Install 7D2D Dedicated Server via SteamCMD
3. Copy modpack to server

### 2. Server Configuration

#### serverconfig.xml
Key settings for House Flipper modpack:
```xml
<property name="ServerName" value="House Flipper AE"/>
<property name="ServerDescription" value="Building-focused survival server"/>
<property name="ServerMaxPlayerCount" value="24"/>
<property name="GameDifficulty" value="2"/>
<property name="BloodMoonFrequency" value="0"/>  <!-- No hordes for building -->
<property name="DayNightLength" value="60"/>      <!-- 60-minute days -->
<property name="ServerPort" value="26900"/>
<property name="TelnetEnabled" value="true"/>
<property name="TelnetPort" value="8081"/>
```

#### Mod Deployment
1. **Copy modpack** to server `Mods/` directory
2. **Run post-install script** if needed for large assets
3. **Verify mod structure**:
   ```bash
   ls -la Mods/
   # Ensure DLLs are in Assemblies/ subfolders
   ```

### 3. Pelican Panel (Docker) Deployment

The repository includes a Pelican Panel egg configuration.

#### Egg Features
- Automatic mod deployment from GitHub
- Environment variables for configuration
- Built-in backup system
- Web-based management

#### Using the Egg
1. Import egg JSON to Pelican Panel
2. Create new server instance
3. Set environment variables:
   - `GITHUB_REPO`: `Midknightloki/HouseFlipperAE`
   - `MODPACK_BRANCH`: `main`
4. Start server - mods auto-deploy

#### Manual Docker Deployment
```bash
docker run -d \
  --name 7d2d-hfae \
  -p 26900:26900/tcp \
  -p 26900:26900/udp \
  -v /path/to/saves:/home/container/.local/share/7DaysToDie \
  -v /path/to/HouseFlipperAE/Mods:/home/container/Mods \
  -e SERVER_NAME="House Flipper AE" \
  vinanrra/7d2d-server:latest
```

### 4. Server Maintenance

#### Regular Tasks
- **Daily**: Check logs for errors
- **Weekly**: Backup world saves
- **Monthly**: Update mods if new versions available
- **After updates**: Test on local server first

#### Backup Strategy
```powershell
# Backup script
$date = Get-Date -Format "yyyy-MM-dd"
$backupPath = "Backups/$date"
Copy-Item -Path "Mods" -Destination "$backupPath/Mods" -Recurse
Copy-Item -Path ".local/share/7DaysToDie/Saves" -Destination "$backupPath/Saves" -Recurse
Compress-Archive -Path $backupPath -DestinationPath "$backupPath.zip"
```

---

## Troubleshooting Common Issues

### 1. ModLauncherV5 Deployment Issues

#### Problem: Files Not Downloading
**Cause**: Git LFS enabled, launcher downloads pointer files
**Solution**: Remove LFS, commit actual files, push again

#### Problem: Mods Folder Empty After Install
**Cause**: Wrong GitHub path in configuration
**Solution**: Verify `GitHub_ModsPath` in `modlauncherconfiguration.xml`

### 2. Server-Side Issues

#### Problem: ERR LootContainer 'X' unknown
**Cause**: Mod overrides `loot.xml` without including vanilla definitions
**Solution**: Create compatibility patch with append xpath

Example patch:
```xml
<configs>
    <append xpath="/lootcontainers">
        <lootcontainer id="missingContainer">
            <!-- Restore vanilla definition -->
        </lootcontainer>
    </append>
</configs>
```

#### Problem: DLL Not Loading
**Cause**: DLL in wrong location (V2.4 requires Assemblies subfolder)
**Solution**: 
```powershell
# Move DLLs to correct location
New-Item -ItemType Directory -Path "Mods/ModName/Assemblies" -Force
Move-Item "Mods/ModName/*.dll" "Mods/ModName/Assemblies/"
```

### 3. Client-Side Issues

#### Problem: Missing Items/Blocks
**Cause**: Mod not loading, wrong load order, or missing dependencies
**Solution**:
1. Check mod list in-game (F1)
2. Verify load order (prefix numbers)
3. Check for missing dependency mods
4. Review client logs for errors

#### Problem: UI Not Showing
**Cause**: UI framework not loaded first
**Solution**: Ensure load order:
- 00000-Gears
- 00000-Quartz  
- 00001-SMXcore
- 00001-zSMX* (other UI mods)

---

## Best Practices

### 1. Development

#### Always Test First
- Never push untested changes to main
- Use local test environment
- Test in both single player and multiplayer
- Check logs for warnings/errors

#### Document Everything
- Update README for user-facing changes
- Update TROUBLESHOOTING for known issues
- Update curated_mod_list for mod changes
- Comment complex XML configurations

#### Keep It Simple
- Fewer mods = fewer conflicts
- Prefer append over set in XML
- Avoid overwriting vanilla content unless necessary
- Use compatibility patches for fixes

### 2. Repository

#### Clean Commit History
- Make atomic commits (one change per commit)
- Write clear commit messages
- Don't commit generated files
- Don't commit local config files

#### Version Control
- Tag all releases
- Use semantic versioning
- Keep changelog updated
- Document breaking changes

### 3. Deployment

#### Staged Rollout
1. Test locally
2. Test on private test server
3. Deploy to staging server
4. Monitor for issues
5. Deploy to production

#### Communication
- Announce updates in advance
- Provide changelog to users
- Document breaking changes
- Offer rollback instructions

### 4. Support

#### User Support
- Provide clear installation instructions
- Include troubleshooting guide
- Respond to issues on GitHub
- Create FAQ for common questions

#### Issue Tracking
- Use GitHub Issues for bug reports
- Label issues appropriately
- Link commits to issues
- Close issues when resolved

---

## Quick Reference

### Common Commands

```powershell
# Development
git status                                    # Check changes
git add Mods/NewMod                           # Stage specific mod
git commit -m "Add: NewMod v1.0"              # Commit
git push                                      # Push to GitHub

# Testing
Select-String -Path "logs/latest.log" -Pattern "ERR "  # Find errors
Get-ChildItem -Recurse *.dll                  # Find all DLLs

# Deployment
git tag -a v2.0.0 -m "Release v2.0.0"         # Tag release
git push origin v2.0.0                         # Push tag

# Maintenance
Get-ChildItem -Recurse | Where {$_.Length -gt 100MB}  # Find large files
```

### File Locations

- **Client logs**: `7DaysToDie_Data/output_log.txt`
- **Server logs**: `logs/latest.log`
- **Server config**: `serverconfig.xml`
- **Mod config**: `modlauncherconfiguration.xml`
- **Save files**: `.local/share/7DaysToDie/Saves/`

### Important URLs

- **Repository**: https://github.com/Midknightloki/HouseFlipperAE
- **ModLauncher URL**: https://raw.githubusercontent.com/Midknightloki/HouseFlipperAE/main/modlauncherconfiguration.xml
- **Releases**: https://github.com/Midknightloki/HouseFlipperAE/releases
- **Issues**: https://github.com/Midknightloki/HouseFlipperAE/issues

---

## Lessons Learned (House Flipper AE Development)

### Critical Discoveries

1. **Git LFS Incompatibility**: ModLauncherV5 downloads pointer files, not actual assets. Never use LFS.

2. **V2.4 DLL Requirement**: All DLLs must be in `Assemblies/` subfolder, not mod root.

3. **Loot Container Overrides**: Mods that override `loot.xml` often remove vanilla containers. Always create compatibility patches.

4. **Load Order Matters**: UI frameworks must load first (00000), patches must load last (999).

5. **Large File Handling**: Files >100MB need GitHub Releases + download scripts, not repository commits.

### What Worked Well

- Numeric prefixes for load order (00000, 00001, 999)
- Compatibility patch approach for fixing conflicts
- User-friendly .bat wrapper for PowerShell scripts
- Comprehensive troubleshooting documentation
- Testing in verified working installation first

### What to Avoid

- Overwriting vanilla content (use append xpath)
- Committing large files to repository
- Enabling Git LFS
- Removing vanilla definitions when overriding XMLs
- Pushing untested changes to main branch
- Ignoring warning messages in logs

---

**Remember**: Take your time, test thoroughly, and document everything. Future you will thank current you!
