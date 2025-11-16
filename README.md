# House Flipper: Apocalypse Edition

**Version 2.0** - A curated building and exploration modpack for 7 Days to Die V2.4 (1.0 Stable)

## Overview

House Flipper: Apocalypse Edition is a carefully curated modpack built from a verified working installation. It enhances the building and exploration experience with modern UI improvements, extensive decoration options, quality of life features, and additional content - all while maintaining stability and compatibility.

## Features

✅ **Modern UI Suite** - SMX UI 2.3.9.0 with integrated minimap and customizable settings via Gears  
✅ **Building & Decoration** - LittleRedSonja plumbing/decor, MPLogue prefabs, PyroPaints customization  
✅ **Quality of Life** - BeyondStorage2, Easy Sorter, OcbDensityHoe terrain tools, Grumpee's starter bundles  
✅ **Additional Content** - New prefabs, urban decay themes, trader modifications  
✅ **Vehicle Support** - Bobcat Vehicle for efficient material transportation  
✅ **Verified Configuration** - Built from tested, known-working installation  
✅ **Multiplayer Ready** - All mods support multiplayer/server play  
✅ **One-Step Installation** - Easy setup via ModLauncherV5  

## Installation

### Quick Install (Recommended)

1. Download [7D2D Mod Launcher V5](https://7d2dmodlauncher.org/)
2. Install and open ModLauncherV5
3. Go to "Install New Mod" → "Add Custom Mod URL"
4. Paste this URL: `https://raw.githubusercontent.com/Midknightloki/HouseFlipperAE/main/modlauncherconfiguration.xml`
5. Click "Install" - the launcher handles everything automatically
6. Start a new game world

### Manual Installation

1. Download all mod files from the GitHub repository's `Mods/` folder
2. Extract all archives to your 7 Days to Die `Mods/` directory
3. Ensure proper load order (see Mod List below)
4. Start the game - mods will load automatically

## Mod List

### UI Framework (00000-00001)
- **Gears** v5.0.1 - Settings framework for in-game mod configuration
- **Quartz** v6.0.1 - UI framework providing core functionality
- **SMXcore** v2.3.9.0 - Core library for SMX UI suite
- **SMXhud** v2.3.9.0 - HUD replacement with integrated minimap
- **SMXmenu** v2.3.9.0 - Enhanced menu system
- **SMXui** v2.3.9.0 - Improved in-game UI

### Gameplay Modifications (001)
- **No trader rekt** v2.0 - Trader balancing adjustments

### Building & Content (01-1)
- **MPLogue Prefabs** v2.0.1 - Additional POI prefabs for world generation
- **MPLogue UrbanDecay** v1.2.1 - Urban decay themed buildings and content
- **BobcatVehicle** v1.0 - Bobcat vehicle for material transportation
- **LittleRedSonja UBBI V2** v1.0.5 - Plumbing, decorative, and building pieces
- **Grumpee's starter bundles** v2.0 - Helpful starting equipment

### Decoration & Storage (3-4)
- **PyroPaints** v2.0.51.0 - Advanced painting and decoration system
- **BeyondStorage2** v2.3.5 - Enhanced storage solutions

### Quality of Life (7-8)
- **Easy Sorter** v3.1 - Inventory sorting utilities
- **OcbDensityHoe** v0.6.0 - Terrain modification tools

## Configuration

### Server Configuration

If running a multiplayer server, add these settings to `serverconfig.xml`:

```xml
<!-- Disable bloodmoon horde nights -->
<property name="BloodMoonFrequency" value="0" />

<!-- Adjust zombie population if desired -->
<property name="ZombieMaxAnimals" value="25" />
<property name="ZombieMaxCount" value="50" />

<!-- Building damage settings -->
<property name="BlockDamagePlayer" value="true" />
<property name="BlockDamageAI" value="true" />
<property name="ShowZombiePathInClient" value="false" />
```

### Single-Player Settings

When creating a new world:

- **Horde Night Frequency**: Off or Minimal
- **Zombie Sprint**: Disabled
- **Difficulty**: Scavenger or Nomad (recommended)
- **Loot Respawn**: Adjust as desired

## Mod Load Order

The modpack requires this specific load order for optimal performance:

1. **CP Modded Core V2** - MUST be first
2. **CP Modded AIO No Traders** - Depends on Core
3. **CP Compat Patch** - Fixes compatibility issues
4. **CP Modded Traders** - Adds trader content
5. Client-side mods (CATUI, Quartz, SPuppyMiniMap) - Order doesn't matter
6. Building/Feature mods (LittleRedSonja, BobcatVehicle) - Order doesn't matter

**Note:** ModLauncherV5 handles load order automatically. For manual installation, mods are named with prefixes (00_, 01_, etc.) to enforce correct order.

## Requirements

- **Game Version**: 7 Days to Die 2.4 b7 or compatible
- **Mod Launcher**: 7D2D Mod Launcher V5 (recommended)
- **Recommended Specs**: 8GB+ RAM, SSD, Mid-range GPU
- **Disk Space**: ~3-4 GB for extracted mods

## Performance Notes

The CP Modded ecosystem is comprehensive and can impact performance on lower-end systems:

- Recommend: 8GB+ RAM, SSD, Mid-range GPU
- Consider removing one or more CP mods if experiencing lag
- Can disable specific CP features in their Config folders

## Troubleshooting

For common issues and solutions, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Support

- **GitHub Issues**: https://github.com/Midknightloki/HouseFlipperAE/issues
- **Discussions**: https://github.com/Midknightloki/HouseFlipperAE/discussions

## Credits

### Mod Authors

- **CP Modded Series** - CP team (ComPoPack)
- **LittleRedSonja** - LittleRedSonja & community
- **CATUI** - CATUI author
- **Quartz** - Quartz author
- **SPuppyMiniMap** - SPuppy
- **BobcatVehicle** - Bobcat author

### Modpack

- **Pack Curator**: Loki Midknight
- **Version**: 1.0.0
- **Game Version**: 7 Days to Die 2.4 b7
- **Last Updated**: November 2025

## License

This modpack includes mods from various authors. Please respect their individual licenses and give credit where due.

---

**Happy Building!** 🏠

For more information, see [CONTEXT.md](CONTEXT.md) for background and development context.
