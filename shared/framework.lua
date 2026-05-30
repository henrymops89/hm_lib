-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Shared Framework Detection
-- ══════════════════════════════════════════════════════════════════

HMLib = {
    Framework = 'standalone',
    Inventory = 'standalone',
    Banking   = 'standalone',
    Target    = 'none',
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
    print(('^2  Framework: ^7 %-15s'):format(HMLib.Framework:upper()))
    print(('^2  Inventory: ^7 %-15s'):format(HMLib.Inventory))
    print(('^2  Banking:   ^7 %-15s'):format(HMLib.Banking))
    print(('^2  Target:    ^7 %-15s'):format(HMLib.Target))
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

-- ── Dynamic Exports ─────────────────────────────────────────────

exports('GetFramework', GetFramework)
exports('GetInventory', GetInventory)
exports('GetBanking',   GetBanking)
exports('GetTargetSystem', GetTargetSystem)

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
