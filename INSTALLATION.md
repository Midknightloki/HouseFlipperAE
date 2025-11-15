# House Flipper: Apocalypse Edition - Installation & Setup

## Quick Start

### For HouseFlipperAEModLauncherV5 Users (One-Click Installation)
1. Open HouseFlipperAEModLauncherV5
2. Search for "House Flipper: Apocalypse Edition" by Loki Midknight
3. Click "Install" - the launcher handles everything automatically
4. Start a new game world

### For Manual Installation
1. Download all `.zip` and `.7z` files from the GitHub Releases page
2. Create a new folder in your 7DTD Mods directory if it doesn't exist
3. Extract all archives to your `Mods/` folder
4. Start the game - 7DTD will load mods in alphabetical order by default

## What's Included

| Mod | Type | Purpose |
|-----|------|---------|
| CP Modded Core V2 | Core | Foundation for CP ecosystem |
| CP Modded AIO No Traders | Overhaul | Large content additions (pre-configured for reduced hordes) |
| CP Compat Patch | Compatibility | Fixes interactions between CP mods |
| CP Modded Traders | Content | Trader locations and behavior |
| CATUI | UI | Enhanced user interface |
| Quartz | UI | Additional UI enhancements |
| SPuppyMiniMap | Navigation | In-game minimap |
| LittleRedSonja_UBBI | Building | Tons of decoration and building pieces |
| BobcatVehicle | Content | Vehicle functionality |

## Game Configuration for Pure Building Experience

### Server Configuration (Optional but Recommended)
If hosting a server with this modpack, add these lines to your `serverconfig.xml`:

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

### Single-Player Configuration
Create a new world and adjust these settings in the game options:
- **Horde Night Frequency**: Off or Minimal
- **Zombie Sprint**: Disabled
- **Loot Respawn**: Adjust as desired
- **Difficulty**: Scavenger or Nomad (recommended)

## Mod Load Order (Important!)

The modpack requires this specific load order for optimal performance:

1. **CP Modded Core V2** - MUST be first
2. **CP Modded AIO No Traders** - Depends on Core
3. **CP Compat Patch** - Fixes compatibility issues
4. **CP Modded Traders** - Adds trader content
5. Client-side mods (CATUI, Quartz, SPuppyMiniMap) - Order doesn't matter
6. Building/Feature mods (LittleRedSonja, BobcatVehicle) - Order doesn't matter

**HouseFlipperAEModLauncherV5 handles this automatically.**

For manual installation, rename mod folders with prefixes if needed:
```
00_CP_Modded_Core_V2
01_CP_Modded_AIO_No_Traders
02_CP_Compat_Patch
03_CP_Modded_Traders
...
```

## Game Features

✨ **Building-Focused Gameplay**
- Thousands of decorative and functional building blocks
- No pressure from constant horde attacks
- Biome progression disabled for consistent experience

✨ **Quality of Life**
- Modern UI improvements (CATUI)
- Enhanced features (Quartz)
- In-game minimap for navigation

✨ **Multiplayer Compatible**
- Works on servers
- Works in co-op

## Troubleshooting

### Mods not loading
**Check:** Are all zip files extracted to the Mods folder?
**Solution:** Use HouseFlipperAEModLauncherV5 for automatic extraction

### Missing building pieces
**Check:** LittleRedSonja mod loaded?
**Solution:** Verify mod folder name doesn't have numbers that would load it first

### Still getting horde nights
**Check:** BloodMoonFrequency setting in serverconfig.xml (if on server)
**Solution:** 
- Set to `<property name="BloodMoonFrequency" value="0" />`
- Or ensure you're using the "No Traders" version of CP Modded AIO

### Game crashing on startup
**Check:** Load order - CP Core must be first
**Solution:** Rename folders with 00_, 01_, etc. prefixes to ensure correct order

## Performance Notes

The CP Modded ecosystem is comprehensive and can impact performance on lower-end systems:
- Recommend: 8GB+ RAM, SSD, Mid-range GPU
- Consider removing one or more CP mods if experiencing lag
- Can disable specific CP features in their Config folders

## Updates & Support

- Report issues on the GitHub repository: https://github.com/Midknightloki/HouseFlipperAE/issues
- Check the repository for updates to this modpack

## Version Information
- **Modpack Version:** 1.0.0
- **7DTD Version Required:** 2.4 b7
- **Release Date:** November 15, 2025

---

**Enjoy your apocalyptic home renovation project!** 🏠
