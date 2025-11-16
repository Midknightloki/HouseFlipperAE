# Context & Background

## Project Overview

House Flipper: Apocalypse Edition was created to provide a building-focused experience for 7 Days to Die players who want to focus on construction, renovation, and creative building without the constant pressure of horde nights and increasing biome difficulty.

## Design Philosophy

### Core Principles

1. **Building First** - The modpack prioritizes construction and decoration over combat
2. **No Horde Pressure** - Eliminates or significantly reduces horde nights
3. **Consistent Difficulty** - Removes biome progression for uniform challenge
4. **Quality of Life** - Enhances the building experience with UI improvements
5. **Easy Installation** - One-click setup via ModLauncherV5

## Modpack Development History

### Initial Concept

The modpack was conceived as a response to players wanting to use 7 Days to Die's robust building system without the survival pressure. Many players enjoyed the construction mechanics but found constant horde nights disruptive to their creative process.

### Mod Selection Process

Mods were selected based on:

1. **Compatibility** - All mods work together without conflicts
2. **Building Focus** - Emphasis on construction and decoration tools
3. **Performance** - Balance between features and system requirements
4. **Maintenance** - Active mod development and community support

### Key Decisions

- **CP Modded AIO "No Traders"** - Chosen specifically for its pre-configured reduced horde settings
- **GitHub Repository Structure** - Using `DownloadMode: GitHub` to host mods directly in the repo (like TongoMod35)
- **Git LFS Integration** - Required for large mod files to avoid GitHub's size limits

## Technical Implementation

### Repository Structure

The modpack uses a GitHub-based approach where:

- Mods are stored as extracted folders in the `Mods/` directory
- ModLauncherV5 downloads directly from the repository structure
- Git LFS handles large files (Unity resources, DLLs, prefabs)
- XML configuration points to the repository URL

### Load Order Management

Mods are named with numeric prefixes to ensure correct load order:

- `00_CP_Modded_Core_V2` - Must load first
- `01_CP_Modded_AIO_No_Traders` - Depends on Core
- `02_CP_Compat_Patch` - Compatibility layer
- And so on...

This ensures dependencies are loaded in the correct sequence.

### Horde Night Configuration

Horde nights are disabled through multiple layers:

1. **CP Modded AIO "No Traders"** - Pre-configured for reduced hordes
2. **HFA_Disable_Hordes_Biomes** - Custom modlet for additional control
3. **Server Configuration** - `BloodMoonFrequency = 0` in serverconfig.xml
4. **Game Settings** - Horde frequency set to Off in world creation

## Development Challenges & Solutions

### Large File Management

**Challenge**: GitHub has a 2GB limit on pack files  
**Solution**: 
- Git LFS for large files (.unity3d, .dll, .mesh, etc.)
- Repository-based hosting instead of releases
- Clean git history with single initial commit

### Mod Launcher Integration

**Challenge**: ModLauncherV5 requires specific XML format  
**Solution**: 
- Uses `DownloadMode: GitHub` pointing to repository URL
- Mods stored as extracted folders (not ZIP files)
- Proper XML structure matching working modpacks (TongoMod35)

### Load Order Complexity

**Challenge**: CP mods have strict dependency requirements  
**Solution**: 
- Numeric prefixes enforce load order
- Clear documentation of dependencies
- ModLauncherV5 handles ordering automatically

## Project Goals

### Current Version (1.0.0)

- ✅ Stable modpack with all features working
- ✅ One-click installation via ModLauncherV5
- ✅ Comprehensive documentation
- ✅ GitHub repository ready for distribution

### Future Considerations

- Additional building mods (pending compatibility testing)
- Server configuration templates
- Visual showcase documentation
- Video installation guide

## Repository Management

### Scripts

All development scripts are stored in the `scripts/` folder (ignored by git):

- `extract_mods_for_github.ps1` - Move mods from Server folder with Git LFS setup
- `start_fresh_repo.ps1` - Re-initialize repository with clean history
- `commit_mods.ps1` - Quick commit script for mod updates
- Various utility scripts for troubleshooting

### Documentation

Documentation is organized into three main files:

- **README.md** - Main documentation for users
- **CONTEXT.md** - This file (background and technical context)
- **TROUBLESHOOTING.md** - Common issues and solutions

## Acknowledgments

This modpack builds on the excellent work of the 7 Days to Die modding community, particularly:

- The CP Modded team for creating such comprehensive content
- ModLauncherV5 developers for making mod management accessible
- All the individual mod authors whose work makes this pack possible

---

For user-facing documentation, see [README.md](README.md).  
For troubleshooting, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

