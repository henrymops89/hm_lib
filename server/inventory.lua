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
        -- GetItemTotalAmount removed in newer QS versions; iterate GetInventory instead
        local inventory = exports['qs-inventory']:GetInventory(src)
        local count = 0
        if inventory then
            for _, slot in pairs(inventory) do
                if slot and slot.name == item then
                    count = count + (slot.amount or slot.count or 1)
                end
            end
        end
        return count
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:GetItemsTotalAmount(src, item)
    elseif inv == 'core_inventory' then
        return exports['core_inventory']:getItemCount(src, item)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:GetItemCount(src, item)
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

function AddItem(src, item, amount, metadata)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        return exports.ox_inventory:AddItem(src, item, amount, metadata)
    elseif inv == 'wasabi_inventory' then
        return exports.wasabi_inventory:AddItem(src, item, amount, metadata)
    elseif inv == 'chezza-inventory' then
        return exports['chezza-inventory']:AddItem(src, item, amount, metadata)
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:AddItem(src, item, amount, metadata)
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'core_inventory' then
        return exports['core_inventory']:addItem(src, item, amount, metadata)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'origen_inventory' then
        return exports['origen_inventory']:addItem(src, item, amount, nil, metadata)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'esx' or inv == 'esx_inventory' or inv == 'mf-inventory' or inv == 'ak47_inventory' then
        local xPlayer = GetPlayer(src)
        if xPlayer then xPlayer.addInventoryItem(item, amount) return true end
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        if player then return player.Functions.AddItem(item, amount, nil, metadata) end
    end
    return false
end

function RemoveItem(src, item, amount, metadata)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        return exports.ox_inventory:RemoveItem(src, item, amount, metadata)
    elseif inv == 'wasabi_inventory' then
        return exports.wasabi_inventory:RemoveItem(src, item, amount, metadata)
    elseif inv == 'chezza-inventory' then
        return exports['chezza-inventory']:RemoveItem(src, item, amount, metadata)
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'core_inventory' then
        return exports['core_inventory']:removeItem(src, item, amount)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'origen_inventory' then
        return exports['origen_inventory']:removeItem(src, item, amount)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'esx' or inv == 'esx_inventory' or inv == 'mf-inventory' or inv == 'ak47_inventory' then
        local xPlayer = GetPlayer(src)
        if xPlayer then xPlayer.removeInventoryItem(item, amount) end
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        if player then player.Functions.RemoveItem(item, amount) end
    end
end
