# hm_lib — Universal Bridge Library for FiveM

> Centralized multi-framework bridge for all MopsScripts resources.  
> Zero manual config. Fully automatic detection. One unified API.

[![Version](https://img.shields.io/badge/version-1.1.0-blue)](https://github.com/henrymops89/hm_lib)
[![License](https://img.shields.io/badge/license-Proprietary-red)](https://mopsscripts.tebex.io)
[![FiveM](https://img.shields.io/badge/FiveM-CFX-orange)](https://cfx.re)

---

## Overview

`hm_lib` is the shared foundation used internally by all MopsScripts resources. It abstracts away framework, inventory, banking, target, garage and vehicle key differences — so your scripts work on any server without a single line of manual config.

Drop it in, start it, and let it detect everything automatically.

---

## Features

### 🧠 Auto-Detection at Runtime
hm_lib detects your entire server stack on first use and logs the result to the console:

```
══════════════════════════════════════════════
   HM Lib — System Detection
══════════════════════════════════════════════
  Framework:     QBX
  Inventory:     ox_inventory
  Banking:       renewed-banking
  Target:        ox_target
  Garage:        qb-garages
  VehicleKeys:   qb-vehiclekeys
══════════════════════════════════════════════
```

---

### 🌐 Framework Support

| Framework       | Status |
|----------------|--------|
| QBox (qbx_core) | ✅ |
| QBCore (qb-core) | ✅ |
| ESX (es_extended) | ✅ |

---

### 🏷️ Inventory Support (13+)

| Resource | Status |
|----------|--------|
| ox_inventory | ✅ |
| qb-inventory | ✅ |
| qs-inventory | ✅ |
| ps-inventory | ✅ |
| tgiann-inventory | ✅ |
| wasabi_inventory | ✅ |
| codem-inventory | ✅ |
| chezza-inventory | ✅ |
| core_inventory | ✅ |
| origen_inventory | ✅ |
| mf-inventory | ✅ |
| ak47_inventory | ✅ |
| esx_inventory | ✅ |

---

### 💰 Banking Support (10+)

| Resource | Status |
|----------|--------|
| renewed-banking | ✅ |
| fd_banking | ✅ |
| wasabi_banking | ✅ |
| okokBanking | ✅ |
| ox_core | ✅ |
| qb-banking | ✅ |
| new_banking | ✅ |
| pepe-banking | ✅ |
| tgg-banking | ✅ |
| tgiann-bank | ✅ |

---

### 🎯 Target Support

| Resource | Status |
|----------|--------|
| ox_target | ✅ |
| qb-target | ✅ |
| qtarget | ✅ |
| bt-target | ✅ |
| meta_target | ✅ |

---

### 🚗 Garage & Vehicle Keys Support

**Garages:** `cd_garage`, `qb-garages`, `renewed-garages`, `ps-garages`, `origen_garage`, `tz_garages`, `esx_garage` — falls back to built-in if none found.

**Vehicle Keys:** `qb-vehiclekeys`, `qs-vehiclekeys`, `wasabi_carkeys`, `renewed-vehiclekeys`, `cd_garage`

---

## Installation

1. Download and place `hm_lib` into your resources folder
2. Add `ensure hm_lib` to your `server.cfg` — **before** any MopsScripts resources
3. That's it. No config required.

**Dependency:** [`ox_lib`](https://github.com/overextended/ox_lib) must be running.

---

## Exports

### Shared

```lua
-- Detection
exports.hm_lib:GetFramework()         -- returns 'qbx' | 'qb' | 'esx' | 'standalone'
exports.hm_lib:GetInventory()         -- returns inventory resource name
exports.hm_lib:GetBanking()           -- returns banking resource name
exports.hm_lib:GetTargetSystem()      -- returns target resource name or 'none'
exports.hm_lib:GetGarageSystem()      -- returns garage resource name or 'builtin'
exports.hm_lib:GetVehicleKeysSystem() -- returns vehicle keys resource name or 'none'
exports.hm_lib:GetInteractionMode()   -- returns 'target' or 'fallback'
exports.hm_lib:IsResourceStarted(resource) -- returns boolean

-- Utilities
exports.hm_lib:FormatCurrency(amount, symbol) -- e.g. '$1.500'
exports.hm_lib:GetDistance(coords1, coords2)  -- vector3 distance
exports.hm_lib:DeepCopy(table)                -- deep copy a table
exports.hm_lib:CreateCommand(name, help, params, callback, group)
```

### Client

```lua
exports.hm_lib:Notify(type, msg, title, duration)
-- type: 'success' | 'error' | 'info' | 'warning'

exports.hm_lib:ProgressBar(duration, label, dict, anim, flag)
-- returns true on completion, false if cancelled

exports.hm_lib:GetPlayerData()
exports.hm_lib:RefreshPlayerData()
exports.hm_lib:GetItemCount(item)         -- client-side item count

exports.hm_lib:AddTargetModel(models, options)
exports.hm_lib:AddTargetEntity(entities, options)
exports.hm_lib:RemoveTarget(name)
exports.hm_lib:RemoveModelTarget(models, name)

exports.hm_lib:GiveJobVehicleKeys(vehicle)
exports.hm_lib:CacheJobVehicle(vehicle)
```

### Server

```lua
-- Player
exports.hm_lib:GetPlayer(src)
exports.hm_lib:GetIdentifier(src)
exports.hm_lib:GetPlayerName(src)
exports.hm_lib:GetPlayerJob(src)
-- returns: { name, label, grade, grade_label }
exports.hm_lib:HasJob(src, jobName | { jobName, ... })
exports.hm_lib:SetJob(src, jobName, grade)
exports.hm_lib:GetPlayerByIdentifier(identifier)
exports.hm_lib:GetPlayerSource(identifier)
exports.hm_lib:GetJobs()
exports.hm_lib:GetGangs()

-- Inventory
exports.hm_lib:GetItemCount(src, item)
exports.hm_lib:AddItem(src, item, amount, metadata)
exports.hm_lib:RemoveItem(src, item, amount, metadata)

-- Banking
exports.hm_lib:GetMoney(src)
exports.hm_lib:AddMoney(src, amount)
exports.hm_lib:RemoveMoney(src, amount)
exports.hm_lib:GetSocietyMoney(society)
exports.hm_lib:AddSocietyMoney(society, amount)
exports.hm_lib:RemoveSocietyMoney(society, amount)

-- Misc
exports.hm_lib:GiveWeapon(src, weaponName, ammo)
exports.hm_lib:NotifyServer(src, type, msg, title, duration)
exports.hm_lib:RegisterUsableItem(name, callback)
```

---

## Usage Example

```lua
-- server.lua
local function GiveReward(src)
    local job = exports.hm_lib:GetPlayerJob(src)

    if not exports.hm_lib:HasJob(src, 'police') then
        exports.hm_lib:NotifyServer(src, 'error', 'You are not a police officer.')
        return
    end

    exports.hm_lib:AddItem(src, 'handcuffs', 1)
    exports.hm_lib:AddMoney(src, 500)
    exports.hm_lib:NotifyServer(src, 'success', 'Reward received!', 'Police', 4000)
end
```

```lua
-- client.lua
local done = exports.hm_lib:ProgressBar(5000, 'Searching...', 'amb@world_human_hang_out_street@male_c@base', 'base')

if done then
    exports.hm_lib:Notify('success', 'Search complete!', 'Info', 3000)
end
```

---

## Requirements

- [ox_lib](https://github.com/overextended/ox_lib)
- FiveM server with `lua54` enabled

---

## Part of the MopsScripts Ecosystem

`hm_lib` is used as the shared bridge by all MopsScripts resources.  
It is available as a **free standalone resource** on GitHub.

> 🔗 [MopsScripts Documentation](https://mopsscripts.mintlify.app)  
> 🛒 [MopsScripts on Tebex](https://mopsscripts.tebex.io)  
