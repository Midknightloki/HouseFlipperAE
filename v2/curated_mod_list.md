# Curated baseline mods — Houseflipper: Apocalypse

This file lists the archives present in `Mods/` (baseline for the overhaul), with short notes and recommendations to match the "Houseflipper: Apocalypse" theme.

- **BobcatVehicle-7943-2-0E-1752969181.zip**
  - Type: Vehicle mod
  - Impact: Low to medium (adds vehicles, mainly QoL)
  - Redistribution: check mod author terms before repackaging
  - Recommendation: Keep — vehicles are useful for transporting building materials.

- **CATUI (for 7DTD 2.3)-5248-2-3-02-1756724332.zip**
  - Type: UI tweaks / HUD
  - Impact: Low (client-side quality of life)
  - Recommendation: Keep — improves UX; confirm compatibility with game version.

- **CP Compat Patch CP EFT IZYS V2-7942-2-3-51-0-1758066740.zip**
  - Type: Compatibility patch (CP ecosystem)
  - Impact: Medium (required if you keep CP mods)
  - Recommendation: Keep if using CP Modded Core/AIO; remove otherwise.

- **CP Modded AIO No Traders V2-7942-2-1-51-1-1753490457.zip**
  - Type: Large overhaul (AIO)
  - Impact: High — likely changes crafting, progression, loot and potentially hordes
  - Redistribution: may have author-specific terms; review readme
  - Recommendation: Review thoroughly — this mod is an overhaul and may conflict with the "no horde / no bio progression" goal. Consider either removing it or creating XML patches to neutralize unwanted systems.

- **CP Modded Core V2-7942-2-1-51-1A-1753512598.zip**
  - Type: Core mod for the CP ecosystem
  - Impact: High — central to many CP modlets
  - Recommendation: Keep only if you intend to run the CP ecosystem. If you want a lighter building-focused pack, consider removing or patching out combat/biome systems.

- **CP Modded Traders V2-7942-2-0-51-0-1752193831.zip**
  - Type: Trader behavior / inventory mod
  - Impact: Medium — affects trading & economy
  - Recommendation: Useful for a player-driven economy; review to ensure it doesn't re-enable horde/biome progression features.

- **LittleRedSonja_ZT_UBBI_V2-8812-1-0-4-1762381913.zip**
  - Type: Building/decoration / plumbing (LittleRedSonja series)
  - Impact: Low to medium — adds decor, plumbing, and quality-of-life building pieces
  - Recommendation: Keep — fits the remodeling/houseflipper theme.

- **Quartz-2409-v6-1-0-1757981700.zip**
  - Type: UI / client-side QoL mod
  - Impact: Low
  - Recommendation: Keep.

- **SPuppyMiniMap-8069-1-3-1753243430.7z**
  - Type: Minimap / navigation
  - Impact: Low (client-side)
  - Recommendation: Keep — helpful for builders and navigation.


Overall recommendations
- Keep client-side QoL mods (CATUI, Quartz, SPuppyMiniMap) and decorative/building mods (LittleRedSonja, BobcatVehicle).
- Carefully evaluate the CP Modded Core/AIO/Traders and compat patch: these are heavy and likely change combat/loot/game progression. If you want a pure building/remodeling experience, either remove them or plan XML patches to neutralize bloodmoons, biome progression, and aggressive spawn-tuning.
- Licensing: for any repackaging or sharing, confirm each mod's redistribution terms. Some mod authors prohibit repackaging or require attribution.

Next technical steps I can take when you confirm:
- Create the HouseFlipperAEModLauncherV5 XML manifest (I will include placeholders for download URLs — you can replace with direct links or file:// URLs).
- Unpack the archives into `Mods/Server/` for a server-side baseline (I can extract the existing zip/7z files present locally).
- Generate XML patch examples that disable bloodmoons and biome progression while leaving building systems intact.
