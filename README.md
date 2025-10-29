<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:6100FF,50:8000FF,100:9F00FF&height=200&section=header&text=ES%20Garage&fontSize=90&fontColor=fff&animation=fadeIn&fontAlignY=35"/>

<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=24&duration=3000&pause=1000&color=8000FF&center=true&vCenter=true&width=600&lines=Sandbox+Framework+Adaptation+%F0%9F%9A%97;Modern+Garage+System+%F0%9F%92%9C;Vue+3+UI+%E2%9C%A8;VIN+Tracking+%2B+Parking+Memory+%F0%9F%93%8D" alt="Typing SVG" />

<br/>

![Version](https://img.shields.io/badge/Version-2.0.0-8000FF?style=for-the-badge&logo=semantic-release&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-Sandbox-00D9FF?style=for-the-badge&logo=fivem&logoColor=white)
![UI](https://img.shields.io/badge/UI-Vue%203-42b883?style=for-the-badge&logo=vue.js&logoColor=white)
![License](https://img.shields.io/badge/License-Custom-FF6B6B?style=for-the-badge&logo=shield&logoColor=white)

<br/>

### ⚠️ Important Notice

**This is NOT the original ES Garage!**

Complete rewrite for **Sandbox Framework ONLY** - Based on [Original ES Garage by Raider#0101](https://discord.gg/EkwWvFS)

</div>

---

## 🔄 Original vs. Sandbox Adaptation

<div align="center">
<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="700">
</div>

### 📊 Side-by-Side Comparison

<table>
<tr>
<th>Feature</th>
<th>Original ES Garage</th>
<th>Sandbox Adaptation</th>
</tr>
<tr>
<td><b>Framework</b></td>
<td>QBCore, ESX, OLDQBCore</td>
<td>✅ <b>Sandbox Framework ONLY</b></td>
</tr>
<tr>
<td><b>Interaction</b></td>
<td>Press E on NPC</td>
<td>✅ <b>F1 Interaction Menu</b></td>
</tr>
<tr>
<td><b>NPCs</b></td>
<td>✅ Required at each garage</td>
<td>❌ Removed</td>
</tr>
<tr>
<td><b>Blips</b></td>
<td>✅ Manual per garage</td>
<td>❌ Uses sandbox-vehicles blips</td>
</tr>
<tr>
<td><b>Zones</b></td>
<td>❌ Coordinate-based</td>
<td>✅ <b>PolyZone integration</b></td>
</tr>
<tr>
<td><b>Garage Config</b></td>
<td>❌ Manual definition required</td>
<td>✅ <b>Auto-loads from _vehicleStorage</b></td>
</tr>
<tr>
<td><b>Vehicle Tracking</b></td>
<td>Plate-based</td>
<td>✅ <b>VIN-based</b></td>
</tr>
<tr>
<td><b>Parking Memory</b></td>
<td>❌ No</td>
<td>✅ <b>Yes (persistent via JSON)</b></td>
</tr>
<tr>
<td><b>Payment System</b></td>
<td>✅ Cash/Bank fees for retrieval</td>
<td>❌ Free access</td>
</tr>
<tr>
<td><b>Impound</b></td>
<td>✅ With fees</td>
<td>❌ Handled by sandbox-vehicles</td>
</tr>
<tr>
<td><b>Database</b></td>
<td>MySQL-async</td>
<td>✅ <b>oxmysql</b></td>
</tr>
<tr>
<td><b>Player Table</b></td>
<td><code>player_vehicles</code></td>
<td>✅ <b><code>owned_vehicles</code></b></td>
</tr>
<tr>
<td><b>Fuel Integration</b></td>
<td>✅ LegacyFuel compatible</td>
<td>❌ Not needed (framework handles)</td>
</tr>
<tr>
<td><b>Car Keys</b></td>
<td>✅ Manual integration</td>
<td>❌ Not needed (framework handles)</td>
</tr>
<tr>
<td><b>UI Framework</b></td>
<td>jQuery + Vue.js (CDN)</td>
<td>✅ <b>Vue 3</b></td>
</tr>
<tr>
<td><b>Responsive</b></td>
<td>❌ Fixed size</td>
<td>✅ <b>1080p/1440p/4K optimized</b></td>
</tr>
<tr>
<td><b>HUD Hiding</b></td>
<td>❌ No</td>
<td>✅ <b>Auto-hides status/location/voice</b></td>
</tr>
<tr>
<td><b>Camera Controls</b></td>
<td>Mouse drag, wheel</td>
<td>✅ <b>Same + enhanced rotation</b></td>
</tr>
<tr>
<td><b>Keyboard Nav</b></td>
<td>❌ No</td>
<td>✅ <b>Arrow keys to scroll</b></td>
</tr>
<tr>
<td><b>Search Feature</b></td>
<td>✅ Yes</td>
<td>❌ Removed (performance)</td>
</tr>
<tr>
<td><b>Statistics</b></td>
<td>Global vehicle counts</td>
<td>✅ <b>Garage-specific counts</b></td>
</tr>
<tr>
<td><b>File Structure</b></td>
<td>Flat (root level)</td>
<td>✅ <b>Organized (ui/ folder)</b></td>
</tr>
<tr>
<td><b>Vehicle Images</b></td>
<td><code>assets/car/</code></td>
<td>✅ <b><code>ui/assets/car/</code></b></td>
</tr>
<tr>
<td><b>Dependencies</b></td>
<td>mysql-async, Framework core</td>
<td>✅ <b>sandbox-*, oxmysql</b></td>
</tr>
</table>

---

## ❌ What Was Removed

<div align="center">

```diff
- Framework Selection - Hardcoded to Sandbox only
- Fuel Integration - Framework handles automatically
- Car Keys Integration - Framework handles automatically
- Payment System - Vehicle access is free
- Impound System - Sandbox-vehicles has its own
- Custom NPC System - Replaced with F1 interaction zones
- Blip System - Sandbox-vehicles manages blips
- Manual Garage Definitions - Auto-loads from _vehicleStorage
- Framework Compatibility Layer - Single framework support
- Search Functionality - Removed for performance
```

</div>

---

## ✅ What Was Added

<div align="center">

```diff
+ VIN-Based Vehicle Tracking - Unique identification per vehicle
+ Parking Space Memory - Vehicles remember their exact spot
+ JSON Persistence - Server-side parking data storage (parking_spaces.json)
+ PolyZone Integration - Automatic zone creation from _vehicleStorage
+ F1 Interaction Menu - Native Sandbox interaction system
+ Modern UI - Vue 3 framework
+ Responsive Design - Scales for 1080p/1440p/4K
+ HUD Hiding - Cleaner UI (hides status, location, voice, map)
+ Keyboard Navigation - Arrow keys to scroll vehicles
+ Organized File Structure - Everything UI-related in ui/ folder
+ Automatic Garage Loading - Reads from sandbox-vehicles _vehicleStorage
+ Garage-Specific Stats - Shows counts per garage, not global
+ Enhanced Camera Controls - Improved rotation logic
+ Oswald Font - Modern, clean typography
```

</div>

---

## ⚙️ Configuration

<table>
<tr>
<td width="50%">

### 📋 Original ES Garage Config

```lua
-- Original structure (NOT USED)
Customize = {}
Customize.Framework = "QBCore"

Customize.Garages = {
    {
        Blips = {
            Position = vector3(...),
            Label = "Car",
            Sprite = 357,
            Color = 18,
        },
        Npc = { Hash = "...", Pos = ... },
        Type = 'car',
        UIName = 'Pilbox Garage',
        Camera = { ... },
        VehPutPos = vector3(...),
        VehSpawnPos = vector4(...),
    },
}

Customize.GetVehFuel = function(Veh)
Customize.SetVehFuel = function(Veh, Fuel)
Customize.Carkeys = function(Plate)
Customize.PriceType = 'cash'
Customize.GaragesPrice = 100
Customize.ImpoundGaragesPrice = 600
```

</td>
<td width="50%">

### ✨ Sandbox Adaptation Config

```lua
-- New simplified structure
Config = {}

-- Whitelist garage IDs
Config.FancyUIGarages = {
    "mba_public_parking",
    "alta_parking",
    "vineyard_public_parking",
    "popular_st_parking",
    "parsons_parking",
    "mirror_park_plaza",
    "morningwood_blvd",
    "puerta_marina",
    "sisyphus",
    "airport",
    "paleto_bay",
    "chumash",
    -- Add more IDs here
}

-- Camera configs (OPTIONAL)
Config.GarageCameras = {
    ["alta_parking"] = {
        vehSpawn = vector4(...),
        location = { 
            posX = -475.0,
            posY = -815.0,
            posZ = 32.0,
            rotX = -15.0,
            rotY = 0.0,
            rotZ = 45.0,
            fov = 50.0 
        },
    },
}

-- NO framework selection
-- NO fuel functions
-- NO payment settings
```

</td>
</tr>
</table>

### 🔧 Config Changes Summary

<table>
<tr>
<th>Setting</th>
<th>Original</th>
<th>Sandbox</th>
</tr>
<tr>
<td><b>Framework</b></td>
<td>Must specify (QBCore/ESX)</td>
<td>❌ Not needed (Sandbox only)</td>
</tr>
<tr>
<td><b>Garage List</b></td>
<td>Manual definition with coordinates</td>
<td>✅ <b>Whitelist IDs only</b></td>
</tr>
<tr>
<td><b>NPCs</b></td>
<td>Hash, Position, Heading</td>
<td>❌ Not needed</td>
</tr>
<tr>
<td><b>Blips</b></td>
<td>Position, Label, Sprite, Color</td>
<td>❌ Not needed</td>
</tr>
<tr>
<td><b>Type</b></td>
<td>car/air/sea</td>
<td>❌ Auto-detected</td>
</tr>
<tr>
<td><b>UIName</b></td>
<td>Manual string</td>
<td>✅ <b>Auto from _vehicleStorage</b></td>
</tr>
<tr>
<td><b>VehPutPos</b></td>
<td>Required vector3</td>
<td>❌ Uses PolyZone</td>
</tr>
<tr>
<td><b>VehSpawnPos</b></td>
<td>Required vector4</td>
<td>❌ Uses parking spaces</td>
</tr>
<tr>
<td><b>Camera</b></td>
<td>Required for each garage</td>
<td>✅ <b>Optional (has defaults)</b></td>
</tr>
<tr>
<td><b>Fuel Functions</b></td>
<td>Required callbacks</td>
<td>❌ Not needed</td>
</tr>
<tr>
<td><b>Car Keys</b></td>
<td>Required callback</td>
<td>❌ Not needed</td>
</tr>
<tr>
<td><b>Price Settings</b></td>
<td>Cash/Bank amounts</td>
<td>❌ Not needed</td>
</tr>
</table>

---

## 🚀 Installation

<div align="center">

### 📦 Requirements

![Sandbox](https://img.shields.io/badge/sandbox--base-v2.0+-00D9FF?style=flat-square&logo=fivem&logoColor=white)
![Vehicles](https://img.shields.io/badge/sandbox--vehicles-REQUIRED-FF6B6B?style=flat-square&logo=fivem&logoColor=white)
![HUD](https://img.shields.io/badge/sandbox--hud-REQUIRED-00D9FF?style=flat-square&logo=fivem&logoColor=white)
![PolyZone](https://img.shields.io/badge/sandbox--polyzone-REQUIRED-00D9FF?style=flat-square&logo=fivem&logoColor=white)
![oxmysql](https://img.shields.io/badge/oxmysql-REQUIRED-4479A1?style=flat-square&logo=mysql&logoColor=white)

</div>

### 📝 server.cfg

```cfg
ensure sandbox-base
ensure sandbox-vehicles
ensure sandbox-hud
ensure sandbox-polyzone

# MUST load AFTER sandbox-vehicles
ensure es-garage
```

### ⚙️ Config Setup

1. Edit `config.lua`
2. Add garage IDs from `sandbox-vehicles/shared/vehicleStorage.lua`
3. Optionally customize camera positions
4. Restart: `restart es-garage`

---

## ⚠️ Migration Warning

<div align="center">

### 🚫 NOT COMPATIBLE with original ES Garage!

```diff
! Cannot Upgrade - This is a complete rewrite
! Different Database - Uses owned_vehicles not player_vehicles
! Different Config - Must reconfigure everything
! Different Framework - Sandbox ONLY, no QBCore/ESX
```

**Treat this as a new installation, not an upgrade.**

</div>

---

## 📁 File Structure

<table>
<tr>
<td width="50%">

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

</td>
<td width="50%">

### Sandbox Adaptation

```
es-garage/
├── ui/
│   ├── assets/car/        (775 images)
│   ├── dist/              (UI files)
│   ├── src/               (UI source)
│   ├── node_modules/      (Included)
│   └── package.json
├── client/client.lua
├── server/server.lua
├── config.lua
├── parking_spaces.json
└── fxmanifest.lua
```

</td>
</tr>
</table>

---

## 👥 Credits & Attribution

<div align="center">

<img src="https://user-images.githubusercontent.com/74038190/212284158-e840e285-664b-44d7-b79b-e264b5e54825.gif" width="400">

</div>

<table>
<tr>
<td width="50%">

### 🎨 Original ES Garage (v1.0.0)

**Author:** Raider#0101  
**Framework:** QBCore, ESX, OLDQBCore  
**Features:** NPC interaction, vehicle management, impound system  

[![Discord](https://img.shields.io/badge/Discord-ES%20Community-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/EkwWvFS)
[![Store](https://img.shields.io/badge/Store-Tebex-00A8E8?style=for-the-badge&logo=shopify&logoColor=white)](https://eyestore.tebex.io/)
[![Video](https://img.shields.io/badge/Video-YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtu.be/ZyGHSdPcUAQ)

</td>
<td width="50%">

### ✨ Sandbox Adaptation (v2.0.0)

**Adapted By:** CodeByBoom  
**Framework:** Sandbox Framework ONLY  
**Type:** Complete rewrite & modernization  

[![Discord](https://img.shields.io/badge/Discord-Join%20Us-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/WXytk8tFQe)

**New Features:**
- VIN tracking
- Parking memory
- PolyZone integration
- Modern Vue 3 UI

</td>
</tr>
</table>

<div align="center">

### 🙏 Attribution

This resource is a **derivative work** based on the original ES Garage by Raider#0101, completely rewritten for Sandbox Framework with modern technology and new features.

</div>

---

## 📄 License

<div align="center">

```diff
! License & Usage Terms
```

**Usage:**
- ✅ Personal use allowed
- ✅ Modification for personal servers
- ✅ Sharing with attribution
- ❌ Commercial resale prohibited
- ❌ Claiming as original work prohibited

**Attribution Required:**
- Credit to original author (**Raider#0101**)
- Credit to Sandbox adaptation (**CodeByBoom**)

**© 2025 | v2.0.0 | Derivative work based on ES Garage by Raider#0101**

</div>

---

<div align="center">

### 💜 Support The Project

<img src="https://user-images.githubusercontent.com/74038190/212284087-bbe7e430-757e-4901-90bf-4cd2ce3e1852.gif" width="100">

<br/>

**⭐ Star this repository** • **💬 Join our Discord** • **📢 Share with others**

<br/><br/>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:6100FF,50:8000FF,100:9F00FF&height=120&section=footer"/>

</div>
