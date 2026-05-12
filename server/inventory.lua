-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Inventory Logic
-- ══════════════════════════════════════════════════════════════════

function GetItemCount(src, item)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(src, item)
    elseif inv == 'wasabi_inventory' then
        return exports.wasabi_inventory:GetItemCount(src, item)
    elseif inv == 'chezza-inventory' then
        return exports['chezza-inventory']:GetItemCount(src, item)
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:GetItemTotalAmount(src, item)
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:GetItemsTotalAmount(src, item)
    elseif inv == 'core_inventory' then
        return exports['core_inventory']:getItemCount(src, item)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:GetItem(src, item, nil, true)
    elseif inv == 'origen_inventory' then
        return exports['origen_inventory']:getItemCount(src, item)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:GetItemCount(src, item)
    elseif inv == 'esx' or inv == 'esx_inventory' or inv == 'mf-inventory' or inv == 'ak47_inventory' then
        local xPlayer = GetPlayer(src)
        return xPlayer and xPlayer.getInventoryItem(item).count or 0
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        local invItem = player.Functions.GetItemByName(item)
        return invItem and invItem.amount or 0
    end
    return 0
end

function AddItem(src, item, amount)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        return exports.ox_inventory:AddItem(src, item, amount)
    elseif inv == 'wasabi_inventory' then
        return exports.wasabi_inventory:AddItem(src, item, amount)
    elseif inv == 'chezza-inventory' then
        return exports['chezza-inventory']:AddItem(src, item, amount)
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:AddItem(src, item, amount)
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:AddItem(src, item, amount)
    elseif inv == 'core_inventory' then
        return exports['core_inventory']:addItem(src, item, amount)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:AddItem(src, item, amount)
    elseif inv == 'origen_inventory' then
        return exports['origen_inventory']:addItem(src, item, amount)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:AddItem(src, item, amount)
    elseif inv == 'esx' or inv == 'esx_inventory' or inv == 'mf-inventory' or inv == 'ak47_inventory' then
        local xPlayer = GetPlayer(src)
        if xPlayer then xPlayer.addInventoryItem(item, amount) return true end
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        if player then return player.Functions.AddItem(item, amount) end
    end
    return false
end

function RemoveItem(src, item, amount)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(src, item, amount)
    elseif inv == 'wasabi_inventory' then
        exports.wasabi_inventory:RemoveItem(src, item, amount)
    elseif inv == 'chezza-inventory' then
        exports['chezza-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'qs-inventory' then
        exports['qs-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'codem-inventory' then
        exports['codem-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'core_inventory' then
        exports['core_inventory']:removeItem(src, item, amount)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        exports['tgiann-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'origen_inventory' then
        exports['origen_inventory']:removeItem(src, item, amount)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        exports['qb-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'esx' or inv == 'esx_inventory' or inv == 'mf-inventory' or inv == 'ak47_inventory' then
        local xPlayer = GetPlayer(src)
        if xPlayer then xPlayer.removeInventoryItem(item, amount) end
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        if player then player.Functions.RemoveItem(item, amount) end
    end
end
