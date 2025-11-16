# Troubleshooting Guide

## Installation Issues

### ModLauncherV5 Won't Install the Modpack

**Symptoms**: Launcher shows errors, modpack doesn't appear, or installation fails

**Solutions**:

1. **Check XML Configuration URL**
   - Ensure the raw GitHub URL is correct: `https://raw.githubusercontent.com/Midknightloki/HouseFlipperAE/main/modlauncherconfiguration.xml`
   - URL must point to the raw file (not the GitHub page)

2. **Verify DownloadMode**
   - The XML uses `DownloadMode: GitHub` pointing to the repository
   - Mods must be extracted folders in the `Mods/` directory (not ZIP files)

3. **Clear Launcher Cache**
   - Close ModLauncherV5
   - Clear cache if option available
   - Try installation again

### Mods Not Loading After Installation

**Symptoms**: Mods don't appear in game, missing items/blocks

**Solutions**:

1. **Check Load Order**
   - CP Modded Core V2 MUST load first
   - Verify mod folders have correct prefixes (00_, 01_, etc.)
   - ModLauncherV5 handles this automatically

2. **Verify Mod Extraction**
   - Ensure all mods are extracted (not ZIP files in Mods folder)
   - Each mod folder should contain `ModInfo.xml`

3. **Game Version Compatibility**
   - Modpack requires 7 Days to Die 2.4 b7 or compatible
   - Check game version matches mod requirements

## Gameplay Issues

### Horde Nights Still Occurring

**Symptoms**: Bloodmoon horde nights happening despite modpack

**Solutions**:

1. **Single-Player**
   - Create a new world (existing saves keep old settings)
   - Set "Horde Night Frequency" to Off in world creation settings

2. **Multiplayer Server**
   - Add to `serverconfig.xml`:
     ```xml
     <property name="BloodMoonFrequency" value="0" />
     ```

3. **Enable Custom Mod**
   - The `HFA_Disable_Hordes_Biomes` mod provides additional horde reduction
   - Ensure it's loaded in ModLauncherV5

4. **Verify Mod Configuration**
   - Check that CP Modded AIO "No Traders" version is installed
   - This version is pre-configured for reduced hordes

### Missing Building Pieces

**Symptoms**: LittleRedSonja blocks/items not appearing in game

**Solutions**:

1. **Check Mod Loaded**
   - Verify LittleRedSonja mod is installed and enabled
   - Check `Mods/` folder contains `07_LittleRedSonja_ZT_UBBI_V2/` or similar

2. **Load Order**
   - LittleRedSonja should load after CP mods
   - Mods are prefixed to ensure correct order

3. **Game Version**
   - Ensure LittleRedSonja version matches your game version
   - Some blocks require specific game versions

4. **Creative Menu**
   - Building pieces appear in creative menu
   - Check under various categories (blocks, items, decorations)

### Game Crashing on Startup

**Symptoms**: Game crashes immediately after loading mods

**Solutions**:

1. **Load Order Issue**
   - CP Modded Core V2 must load first
   - Reinstall using ModLauncherV5 for automatic ordering

2. **Mod Conflicts**
   - Remove any other mods not part of this pack
   - Test with modpack only first

3. **Missing Dependencies**
   - Ensure all CP mods are installed (Core, AIO, Patch, Traders)
   - Missing dependencies can cause crashes

4. **Check Game Logs**
   - Review game log files for specific errors
   - Look for mod loading errors or missing files

## Performance Issues

### Low FPS / Lag

**Symptoms**: Game runs slowly, stuttering, long load times

**Solutions**:

1. **System Requirements**
   - Recommended: 8GB+ RAM, SSD, Mid-range GPU
   - CP Modded ecosystem is resource-intensive

2. **Reduce Mods**
   - Try removing one or more CP mods if needed
   - CATUI and Quartz are less resource-intensive

3. **Game Settings**
   - Lower graphics settings
   - Reduce view distance
   - Disable shadows if struggling

4. **Mod Configuration**
   - Some CP features can be disabled in their Config folders
   - Review CP mod documentation for optimization tips

### Long Loading Times

**Symptoms**: Game takes very long to start or load saves

**Solutions**:

1. **SSD Required**
   - Modpack requires SSD for reasonable load times
   - HDD may cause 5+ minute load times

2. **Memory**
   - Ensure sufficient RAM (8GB+)
   - Close other applications while playing

3. **Save File Size**
   - Large builds can increase save file size
   - Regular save backups recommended

## Server Issues

### Players Can't Connect

**Symptoms**: Multiplayer connection failures

**Solutions**:

1. **Server Mods Required**
   - All players must have the same modpack installed
   - Server and client mods must match exactly

2. **Version Check**
   - Verify server and clients use same game version
   - Ensure modpack version matches (1.0.0)

3. **Port Forwarding**
   - Standard 7DTD ports must be forwarded
   - Check firewall settings

### Server Configuration Not Working

**Symptoms**: Server settings (like BloodMoonFrequency) not applying

**Solutions**:

1. **File Location**
   - `serverconfig.xml` must be in server root directory
   - Restart server after making changes

2. **Syntax**
   - Verify XML syntax is correct
   - Property names are case-sensitive

3. **Game Settings Override**
   - Some settings in world creation override serverconfig.xml
   - Check world-specific settings

## Development / Repository Issues

### Git Push Fails with HTTP 500

**Symptoms**: Getting HTTP 500 errors when pushing to GitHub

**Solutions**:

1. **Git LFS Required**
   - Large files must use Git LFS
   - Run `scripts/setup_git_lfs.ps1` to configure

2. **Repository Size**
   - If pack file exceeds 2GB, you need to start fresh
   - See `scripts/start_fresh_repo.ps1`

3. **Use SSH**
   - SSH is more reliable for large pushes
   - See `scripts/setup_ssh_keys.ps1`

### Mods Not Syncing to GitHub

**Symptoms**: Local mods not matching remote repository

**Solutions**:

1. **Check .gitignore**
   - Ensure `Mods/Server/` is in .gitignore
   - Only `Mods/` (with extracted mods) should be tracked

2. **Git LFS Tracking**
   - Large files must be tracked by Git LFS
   - Check `.gitattributes` has correct patterns

3. **File Structure**
   - Mods must be extracted folders (not ZIP files)
   - Each mod needs its own folder with `ModInfo.xml`

## Getting Help

If you're still experiencing issues:

1. **Check GitHub Issues**
   - Search existing issues: https://github.com/Midknightloki/HouseFlipperAE/issues
   - Create a new issue with:
     - Game version
     - Modpack version
     - Error messages/logs
     - Steps to reproduce

2. **GitHub Discussions**
   - Community help: https://github.com/Midknightloki/HouseFlipperAE/discussions

3. **Game Logs**
   - Check game log files for specific errors
   - Usually in: `%APPDATA%\7DaysToDie\Logs\`

## Common Error Messages

### "Missing object" / "fatal: pack exceeds maximum allowed size"

**Cause**: Repository history too large  
**Solution**: Start fresh repository (see `scripts/start_fresh_repo.ps1`)

### "Permission denied (publickey)"

**Cause**: SSH keys not set up  
**Solution**: See `scripts/setup_ssh_keys.ps1`

### "ModLauncherV5 says 'Invalid XML'"

**Cause**: XML file not accessible as raw URL  
**Solution**: Ensure URL points to raw GitHub file, not the page

---

For more context, see [CONTEXT.md](CONTEXT.md).  
For general information, see [README.md](README.md).

