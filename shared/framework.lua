-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Shared Framework Detection
-- ══════════════════════════════════════════════════════════════════

HMLib = {
    Framework   = 'standalone',
    Inventory   = 'standalone',
    Banking     = 'standalone',
    Target      = 'none',
    Garage      = 'builtin',
    VehicleKeys = 'none',
}

-- ── Detection ───────────────────────────────────────────────────

local function Detect()
    local oldFramework = HMLib.Framework

    -- Framework Detection
    if GetResourceState('es_extended') == 'started' then
        HMLib.Framework = 'esx'
    elseif GetResourceState('qbx_core') == 'started' then
        HMLib.Framework = 'qbx'
    elseif GetResourceState('qb-core') == 'started' then
        HMLib.Framework = 'qb'
    end

    -- Inventory Detection
    if GetResourceState('ox_inventory') == 'started' then
        HMLib.Inventory = 'ox_inventory'
    elseif GetResourceState('codem-inventory') == 'started' or GetResourceState('m-inventory') == 'started' then
        HMLib.Inventory = 'codem-inventory'
    elseif GetResourceState('qs-inventory') == 'started' then
        HMLib.Inventory = 'qs-inventory'
    elseif GetResourceState('ps-inventory') == 'started' then
        HMLib.Inventory = 'ps-inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        HMLib.Inventory = 'qb-inventory'
    elseif GetResourceState('wasabi_inventory') == 'started' then
        HMLib.Inventory = 'wasabi_inventory'
    elseif GetResourceState('esx_inventory') == 'started' then
        HMLib.Inventory = 'esx_inventory'
    elseif GetResourceState('core_inventory') == 'started' then
        HMLib.Inventory = 'core_inventory'
    elseif GetResourceState('mf-inventory') == 'started' then
        HMLib.Inventory = 'mf-inventory'
    elseif GetResourceState('ak47_inventory') == 'started' then
        HMLib.Inventory = 'ak47_inventory'
    elseif GetResourceState('chezza-inventory') == 'started' then
        HMLib.Inventory = 'chezza-inventory'
    elseif GetResourceState('tgiann_inventory') == 'started' or GetResourceState('tgiann-inventory') == 'started' then
        HMLib.Inventory = 'tgiann_inventory'
    elseif GetResourceState('origen_inventory') == 'started' then
        HMLib.Inventory = 'origen_inventory'
    else
        HMLib.Inventory = HMLib.Framework
    end

    -- Banking Detection
    if GetResourceState('renewed-banking') == 'started' then
        HMLib.Banking = 'renewed-banking'
    elseif GetResourceState('fd_banking') == 'started' then
        HMLib.Banking = 'fd_banking'
    elseif GetResourceState('wasabi_banking') == 'started' then
        HMLib.Banking = 'wasabi_banking'
    elseif GetResourceState('okokBanking') == 'started' then
        HMLib.Banking = 'okokBanking'
    elseif GetResourceState('ox_core') == 'started' then
        HMLib.Banking = 'ox_core'
    elseif GetResourceState('p_banking') == 'started' then
        HMLib.Banking = 'p_banking'
    elseif GetResourceState('new_banking') == 'started' then
        HMLib.Banking = 'new_banking'
    elseif GetResourceState('pepe-banking') == 'started' then
        HMLib.Banking = 'pepe-banking'
    elseif GetResourceState('tgg-banking') == 'started' then
        HMLib.Banking = 'tgg-banking'
    elseif GetResourceState('tgiann-bank') == 'started' then
        HMLib.Banking = 'tgiann-bank'
    elseif GetResourceState('qb-banking') == 'started' then
        HMLib.Banking = 'qb-banking'
    else
        HMLib.Banking = HMLib.Framework
    end

    -- Garage Detection
    if GetResourceState('cd_garage') == 'started' then
        HMLib.Garage = 'cd_garage'
    elseif GetResourceState('qb-garages') == 'started' then
        HMLib.Garage = 'qb-garages'
    elseif GetResourceState('renewed-garages') == 'started' then
        HMLib.Garage = 'renewed-garages'
    elseif GetResourceState('origen_garage') == 'started' then
        HMLib.Garage = 'origen_garage'
    elseif GetResourceState('tz_garages') == 'started' then
        HMLib.Garage = 'tz_garages'
    elseif GetResourceState('ps-garages') == 'started' or GetResourceState('ps-garage') == 'started' then
        HMLib.Garage = 'ps-garages'
    elseif GetResourceState('esx_garage') == 'started' or GetResourceState('esx-garage') == 'started' then
        HMLib.Garage = 'esx_garage'
    else
        HMLib.Garage = 'builtin'
    end

    -- Vehicle Keys Detection
    if GetResourceState('cd_garage') == 'started' then
        -- cd_garage uses cd_bridge internally for keys
        HMLib.VehicleKeys = 'cd_garage'
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        HMLib.VehicleKeys = 'qb-vehiclekeys'
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        HMLib.VehicleKeys = 'qs-vehiclekeys'
    elseif GetResourceState('wasabi_carkeys') == 'started' then
        HMLib.VehicleKeys = 'wasabi_carkeys'
    elseif GetResourceState('Renewed-Vehiclekeys') == 'started' or GetResourceState('renewed-vehiclekeys') == 'started' then
        HMLib.VehicleKeys = 'renewed-vehiclekeys'
    elseif GetResourceState('LegacyFuel') == 'started' then
        -- LegacyFuel ships with a basic key stub on some servers
        HMLib.VehicleKeys = 'none'
    else
        HMLib.VehicleKeys = 'none'
    end

    -- Target Detection
    if GetResourceState('ox_target') == 'started' then
        HMLib.Target = 'ox_target'
    elseif GetResourceState('qb-target') == 'started' then
        HMLib.Target = 'qb-target'
    elseif GetResourceState('qtarget') == 'started' then
        HMLib.Target = 'qtarget'
    elseif GetResourceState('meta_target') == 'started' then
        HMLib.Target = 'meta_target'
    elseif GetResourceState('bt-target') == 'started' then
        HMLib.Target = 'bt-target'
    else
        HMLib.Target = 'none'
    end

    -- Console Output
    print('^2══════════════════════════════════════════════^7')
    print('^2   HM Lib — System Detection^7')
    print('^2══════════════════════════════════════════════^7')
    print(('^2  Framework:    ^7 %-15s'):format(HMLib.Framework:upper()))
    print(('^2  Inventory:    ^7 %-15s'):format(HMLib.Inventory))
    print(('^2  Banking:      ^7 %-15s'):format(HMLib.Banking))
    print(('^2  Target:       ^7 %-15s'):format(HMLib.Target))
    print(('^2  Garage:       ^7 %-15s'):format(HMLib.Garage))
    print(('^2  VehicleKeys:  ^7 %-15s'):format(HMLib.VehicleKeys))
    print('^2══════════════════════════════════════════════^7')
end

-- ── Global Getters ──────────────────────────────────────────────

function GetFramework()
    if HMLib.Framework == 'standalone' then Detect() end
    return HMLib.Framework
end

function GetInventory()
    if HMLib.Inventory == 'standalone' then Detect() end
    return HMLib.Inventory
end

function GetBanking()
    if HMLib.Banking == 'standalone' then Detect() end
    return HMLib.Banking
end

function GetTargetSystem()
    if HMLib.Target == 'none' then Detect() end
    return HMLib.Target
end

function GetGarageSystem()
    if HMLib.Garage == 'builtin' and HMLib.Framework == 'standalone' then Detect() end
    return HMLib.Garage
end

function GetVehicleKeysSystem()
    if HMLib.VehicleKeys == 'none' and HMLib.Framework == 'standalone' then Detect() end
    return HMLib.VehicleKeys
end

-- ── Dynamic Exports ─────────────────────────────────────────────

exports('GetFramework',       GetFramework)
exports('GetInventory',       GetInventory)
exports('GetBanking',         GetBanking)
exports('GetTargetSystem',    GetTargetSystem)
exports('GetGarageSystem',    GetGarageSystem)
exports('GetVehicleKeysSystem', GetVehicleKeysSystem)

exports('GetInteractionMode', function()
    local target = exports.hm_lib:GetTargetSystem()
    if target ~= 'none' then
        return 'target'
    end
    return 'fallback'
end)

exports('IsResourceStarted', function(resource)
    return GetResourceState(resource) == 'started'
end)
