# ES Garage - Sandbox Framework Adaptation

**Version 3.0.0** - Adapted from [Original ES Garage by Raider#0101](https://discord.gg/EkwWvFS)

> ⚠️ **This is NOT the original ES Garage!** This is a complete rewrite for Sandbox Framework ONLY.

---

## Original vs. Sandbox Adaptation

### Side-by-Side Comparison

| Feature | Original ES Garage | Sandbox Adaptation |
|---------|-------------------|-------------------|
| **Framework** | QBCore, ESX, OLDQBCore | **Sandbox Framework ONLY** |
| **Interaction** | Press E on NPC | **F1 Interaction Menu** |
| **NPCs** | ✅ Required at each garage | ❌ Removed |
| **Blips** | ✅ Manual per garage | ❌ Uses sandbox-vehicles blips |
| **Zones** | ❌ Coordinate-based | ✅ **PolyZone integration** |
| **Garage Config** | ❌ Manual definition required | ✅ **Auto-loads from _vehicleStorage** |
| **Vehicle Tracking** | Plate-based | ✅ **VIN-based** |
| **Parking Memory** | ❌ No | ✅ **Yes (persistent via JSON)** |
| **Payment System** | ✅ Cash/Bank fees for retrieval | ❌ Free access |
| **Impound** | ✅ With fees | ❌ Handled by sandbox-vehicles |
| **Database** | MySQL-async | **oxmysql** |
| **Player Table** | `player_vehicles` | **`owned_vehicles`** |
| **Fuel Integration** | ✅ LegacyFuel compatible | ❌ Not needed (framework handles) |
| **Car Keys** | ✅ Manual integration | ❌ Not needed (framework handles) |
| **UI Framework** | jQuery + Vue.js (CDN) | **Vue 3 + Vite + Bun** |
| **Build Process** | ❌ None | ✅ **Bun build system** |
| **Dev Mode** | ❌ Not available | ✅ **Live browser preview** |
| **Responsive** | ❌ Fixed size | ✅ **1080p/1440p/4K optimized** |
| **HUD Hiding** | ❌ No | ✅ **Auto-hides status/location/voice** |
| **Camera Controls** | Mouse drag, wheel | **Same + enhanced rotation** |
| **Keyboard Nav** | ❌ No | ✅ **Arrow keys to scroll** |
| **Search Feature** | ✅ Yes | ❌ Removed (performance) |
| **Statistics** | Global vehicle counts | **Garage-specific counts** |
| **File Structure** | Flat (root level) | **Organized (ui/ folder)** |
| **Vehicle Images** | `assets/car/` | **`ui/assets/car/`** |
| **Dependencies** | mysql-async, Framework core | **sandbox-*, oxmysql** |

---

## What Was Removed

Features removed because Sandbox Framework handles them:

1. **Framework Selection** - Hardcoded to Sandbox only
2. **Fuel Integration** - Framework handles automatically
3. **Car Keys Integration** - Framework handles automatically
4. **Payment System** - Vehicle access is free
5. **Impound System** - Sandbox-vehicles has its own
6. **Custom NPC System** - Replaced with F1 interaction zones
7. **Blip System** - Sandbox-vehicles manages blips
8. **Manual Garage Definitions** - Auto-loads from _vehicleStorage
9. **Framework Compatibility Layer** - Single framework support
10. **Search Functionality** - Removed for performance

---

## What Was Added

New features unique to Sandbox adaptation:

1. ✅ **VIN-Based Vehicle Tracking** - Unique identification per vehicle
2. ✅ **Parking Space Memory** - Vehicles remember their exact spot
3. ✅ **JSON Persistence** - Server-side parking data storage (`parking_spaces.json`)
4. ✅ **PolyZone Integration** - Automatic zone creation from _vehicleStorage
5. ✅ **F1 Interaction Menu** - Native Sandbox interaction system
6. ✅ **Modern UI Stack** - Vue 3 + Vite + Bun
7. ✅ **Responsive Design** - Scales for 1080p/1440p/4K
8. ✅ **Dev Mode** - Live browser preview at http://localhost:5173
9. ✅ **HUD Hiding** - Cleaner UI (hides status, location, voice, map)
10. ✅ **Keyboard Navigation** - Arrow keys to scroll vehicles
11. ✅ **Organized File Structure** - Everything UI-related in `ui/` folder
12. ✅ **Automatic Garage Loading** - Reads from sandbox-vehicles `_vehicleStorage`
13. ✅ **Garage-Specific Stats** - Shows counts per garage, not global
14. ✅ **Enhanced Camera Controls** - Improved rotation logic
15. ✅ **Oswald Font** - Modern, clean typography

---

## Configuration

### Original ES Garage Config

```lua
-- Original structure (NOT USED ANYMORE)
Customize = {}
Customize.Framework = "QBCore" -- ESX or QBCore or OLDQBCore

Customize.Garages = {
    {
        Blips = {
            Position = vector3(213.56, -809.54, 31.01),
            Label = "Car",
            Sprite = 357,
            Color = 18,
        },
        Npc = { Hash = "s_m_y_barman_01", Pos = vector3(...), Heading = 340.67 },
        Type = 'car', -- car, air, sea
        UIName = 'Pilbox Garage',
        Camera = {
            vehSpawn = vector4(236.95, -783.71, 30.63, 179.64),
            location = { posX = 233.37, posY = -789.9, posZ = 30.6, ... },
        },
        VehPutPos = vector3(213.936, -792.53, 30.3523),
        VehSpawnPos = vector4(209.64, -791.39, 30.5, 248.63),
    },
}

Customize.GetVehFuel = function(Veh) ... end
Customize.SetVehFuel = function(Veh, Fuel) ... end
Customize.Carkeys = function(Plate) ... end
Customize.PriceType = 'cash' -- cash - bank
Customize.GaragesPrice = 100
Customize.ImpoundGaragesPrice = 600
```

### Sandbox Adaptation Config

```lua
-- New simplified structure
Config = {}

-- List of garage IDs from sandbox-vehicles _vehicleStorage that should use the fancy UI
-- Other garages will use the default sandbox-vehicles list menu
Config.FancyUIGarages = {
    "mba_public_parking",           -- Maze Bank Arena
    "alta_parking",                 -- Alta/Downtown
    "vineyard_public_parking",      -- Vineyard
    "popular_st_parking",           -- Popular Street
    "parsons_parking",              -- Parsons Rehabilitation
    "mirror_park_plaza",            -- Mirror Park Plaza
    "morningwood_blvd",             -- Morningwood Blvd
    "puerta_marina",                -- Puerto del Sol Marina
    "sisyphus",                     -- Sisyphus Theater
    "airport",                      -- LSIA Public Parking
    "paleto_bay",                   -- Paleto Bay
    "chumash",                      -- Chumash
    "route_68",                     -- Route 68
    "harmony",                      -- Harmony
    "san_vitus_parking",            -- San Vitus
    "southside_strawberry_ave",     -- Strawberry Ave
    "casino_parking",               -- Diamond Casino
    "richards_tower_parking",       -- Richards Majestic
    "townhall_public_parking",      -- Town Hall
    "st_fiacre_public",             -- St. Fiacre
    "mount_zonah_public",           -- Mount Zonah
    "vanilla_unicorn_public",       -- Vanilla Unicorn
    "bahama_mama_public",           -- Bahama Mamas
    "autoexotics_public",           -- Auto Exotics Public
}

-- Camera configurations for fancy UI garages (OPTIONAL)
-- If not defined, uses parking spaces from sandbox-vehicles
Config.GarageCameras = {
    ["mba_public_parking"] = {
        vehSpawn = vector4(-203.0, -1940.0, 27.5, 298.0),
        location = { 
            posX = -208.0, posY = -1945.0, posZ = 29.0, 
            rotX = -15.0, rotY = 0.0, rotZ = 30.0, fov = 50.0 
        },
    },
    ["alta_parking"] = {
        vehSpawn = vector4(-470.0, -810.0, 30.5, 0.0),
        location = { 
            posX = -475.0, posY = -815.0, posZ = 32.0, 
            rotX = -15.0, rotY = 0.0, rotZ = 45.0, fov = 50.0 
        },
    },
    ["vineyard_public_parking"] = {
        vehSpawn = vector4(-1900.0, 2034.9, 140.1, 159.0),
        location = { 
            posX = -1905.0, posY = 2030.0, posZ = 142.0, 
            rotX = -15.0, rotY = 0.0, rotZ = 160.0, fov = 50.0 
        },
    },
    -- Add more custom camera configs as needed
}

-- Config.Garages is populated automatically from sandbox-vehicles at runtime
-- NO framework selection, NO fuel functions, NO payment settings
```

### Config Changes Summary

| Setting | Original | Sandbox |
|---------|---------|---------|
| **Framework** | Must specify (QBCore/ESX) | ❌ Not needed (Sandbox only) |
| **Garage List** | Manual definition with coordinates | ✅ **Whitelist IDs only** |
| **NPCs** | Hash, Position, Heading | ❌ Not needed |
| **Blips** | Position, Label, Sprite, Color | ❌ Not needed |
| **Type** | car/air/sea | ❌ Auto-detected |
| **UIName** | Manual string | ✅ **Auto from _vehicleStorage** |
| **VehPutPos** | Required vector3 | ❌ Uses PolyZone |
| **VehSpawnPos** | Required vector4 | ❌ Uses parking spaces |
| **Camera** | Required for each garage | ✅ **Optional (has defaults)** |
| **Fuel Functions** | Required callbacks | ❌ Not needed |
| **Car Keys** | Required callback | ❌ Not needed |
| **Price Settings** | Cash/Bank amounts | ❌ Not needed |

---

## Installation

### Requirements
- ✅ **Sandbox Framework** (v2.0+)
- ✅ **sandbox-vehicles** (REQUIRED)
- ✅ **sandbox-hud**
- ✅ **sandbox-polyzone**
- ✅ **oxmysql**

### server.cfg
```cfg
ensure sandbox-base
ensure sandbox-vehicles
ensure sandbox-hud
ensure sandbox-polyzone

# MUST load AFTER sandbox-vehicles
ensure es-garage
```

### Config Setup
1. Edit `config.lua`
2. Add garage IDs from `sandbox-vehicles/shared/vehicleStorage.lua`
3. Optionally customize camera positions
4. Restart: `restart es-garage`

---

## Migration Warning

⚠️ **NOT COMPATIBLE** with original ES Garage!

If you're coming from original ES Garage:
- ❌ **Cannot upgrade** - This is a complete rewrite
- ❌ **Different database** - Uses `owned_vehicles` not `player_vehicles`
- ❌ **Different config** - Must reconfigure everything
- ❌ **Different framework** - Sandbox ONLY, no QBCore/ESX

**Treat this as a new installation, not an upgrade.**

---

## File Structure

### Original
```
es-garage/
├── assets/
├── client/client.lua
├── server/server.lua
├── config.lua
├── index.html
├── vue.js
└── fxmanifest.lua
```

### Sandbox Adaptation
```
es-garage/
├── ui/
│   ├── assets/car/        (775 vehicle images)
│   ├── dist/              (Built UI files)
│   ├── src/               (Vue 3 source code)
│   └── package.json
├── client/client.lua
├── server/server.lua
├── config.lua
├── parking_spaces.json    (Auto-generated)
└── fxmanifest.lua
```

---

## Development

### Building UI

```bash
cd ui
bun install
bun run dev     # Live preview: http://localhost:5173
bun run build   # Production build
```

---

## Credits

**Original ES Garage (v1.0.0)**
- Author: **Raider#0101**
- Framework: QBCore, ESX, OLDQBCore
- Discord: [ES Community](https://discord.gg/EkwWvFS)
- Store: [Tebex - EYE STORE](https://eyestore.tebex.io/)
- Video: [YouTube Tutorial](https://youtu.be/ZyGHSdPcUAQ)

**Sandbox Adaptation (v3.0.0)**
- Complete rewrite for Sandbox Framework
- Vue 3 + Vite + Bun modernization
- New features: VIN tracking, parking memory, PolyZone integration
- Attribution: Derivative work based on original ES Garage design

---

## License

This resource is a derivative work based on the original ES Garage by Raider#0101, completely rewritten for Sandbox Framework.

**Usage:**
- ✅ Personal use
- ✅ Modification for personal servers
- ✅ Sharing with attribution
- ❌ Commercial resale
- ❌ Claiming as original work

**Attribution required** to both original author (Raider#0101) and Sandbox adaptation work.
