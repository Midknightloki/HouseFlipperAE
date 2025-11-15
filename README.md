# House Flipper: Apocalypse Edition - Modpack Setup Guide

## Overview
This modpack is designed for 7 Days to Die players who want to focus on building and remodeling without the pressure of constant horde nights or biome progression difficulties. It's a one-step installation through the HouseFlipperAEModLauncherV5.

## Mod List & Configuration

### Core Mods (Pre-configured for minimal combat)
1. **CP Modded Core V2** - Foundation for the CP ecosystem
2. **CP Modded AIO No Traders V2** - Large overhaul without traders; horde/bloodmoon settings are pre-configured
3. **CP Compat Patch CP EFT IZYS V2** - Compatibility layer for CP mods
4. **CP Modded Traders V2** - Trader locations and behavior

### Quality of Life / Client-Side Mods
5. **CATUI (for 7DTD 2.3)** - UI improvements and HUD customization
6. **Quartz** - Enhanced UI features
7. **SPuppyMiniMap** - Minimap for navigation

### Building & Decoration Mods
8. **LittleRedSonja ZT UBBI V2** - Building pieces, plumbing, and decoration items
9. **BobcatVehicle** - Vehicle mod for transportation

### Custom Configuration
10. **HFA_Disable_Hordes_Biomes** - Custom patch to ensure horde nights and biome progression are disabled

## Features

✅ **No Bloodmoon/Horde Nights** - Focus on building without coordinated zombie attacks  
✅ **No Biome Progression** - Consistent difficulty across all areas  
✅ **Building-Focused** - LittleRedSonja adds tons of decorative and functional building blocks  
✅ **QoL Improvements** - CATUI, Quartz, and Minimap enhance usability  
✅ **Multiplayer Ready** - All mods support multiplayer/server play  

## Installation Instructions

### One-Step Installation (Recommended)
1. Open HouseFlipperAEModLauncherV5
2. Navigate to the modpack section
3. Search for "House Flipper: Apocalypse Edition" by Loki Midknight
4. Click "Install" - the launcher will download and organize all mods

### Manual Installation (Alternative)
If you prefer manual setup:
1. Download all mod archives from the GitHub release page
2. Extract to your game's `Mods/` directory
3. Ensure the load order matches the list above (CP mods first, client-side second, building mods third)
4. Start a new game world or use this on a new server

## Server Configuration

### Important Settings for Servers
If running this as a multiplayer server, add these settings to `serverconfig.xml`:

```xml
<!-- Disable horde nights entirely (optional - already reduced in this pack) -->
<property name="BloodMoonFrequency" value="0" />

<!-- Reduce overall zombie difficulty if desired -->
<property name="ZombieMaxAnimals" value="25" />
<property name="ZombieMaxCount" value="50" />

<!-- Building blocks won't be damaged by default zombies; only POI zombies are aggressive -->
<property name="BlockDamagePlayer" value="true" />
<property name="BlockDamageAI" value="true" />
```

## Troubleshooting

### Issue: Horde nights still occurring
**Solution:** The CP Modded AIO "No Traders" version significantly reduces hordes. If they're still too frequent, enable the HFA_Disable_Hordes_Biomes mod in the launcher's mod list, or manually patch `Zzzzxcp_Modded_All_In_One_No_Traders/Config/spawning.xml`.

### Issue: Mods not loading in correct order
**Solution:** Use the HouseFlipperAEModLauncherV5 load order system. The official launcher handles dependency resolution automatically.

### Issue: Missing building pieces from LittleRedSonja
**Solution:** Ensure the progression.xml in the LittleRedSonja mod is compatible with your game version. Check that the mod loaded without conflicts in the launcher logs.

## Mod Author Credits
- **CP Modded Series** - CP team (ComPoPack)
- **LittleRedSonja** - LittleRedSonja & community
- **CATUI** - CATUI author
- **Quartz** - Quartz author
- **SPuppyMiniMap** - SPuppy
- **BobcatVehicle** - Bobcat author
- **Pack Curator** - Loki Midknight

## Version
- **Modpack Version:** 1.0.0
- **Game Version:** 7 Days to Die 2.4 b7
- **Last Updated:** November 15, 2025

## Support
For issues or feedback, create an issue on the GitHub repository: https://github.com/Midknightloki/HouseFlipperAE

---

**Happy Building!**
