-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Inventory Logic
-- ══════════════════════════════════════════════════════════════════

function GetItemCount(src, item)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(src, item)
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
    elseif inv == 'codem-inventory' or inv == 'm-inventory' then
        return exports[inv]:GetItemsTotalAmount(src, item)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:GetItemCount(src, item)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:GetItemCount(src, item)
    elseif inv == 'esx' or inv == 'esx_inventory' then
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
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:AddItem(src, item, amount, metadata)
    elseif inv == 'codem-inventory' or inv == 'm-inventory' then
        return exports[inv]:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:AddItem(src, item, amount, nil, metadata)
    elseif inv == 'esx' or inv == 'esx_inventory' then
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
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'codem-inventory' or inv == 'm-inventory' then
        return exports[inv]:RemoveItem(src, item, amount)
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'qb-inventory' or inv == 'ps-inventory' then
        return exports['qb-inventory']:RemoveItem(src, item, amount)
    elseif inv == 'esx' or inv == 'esx_inventory' then
        local xPlayer = GetPlayer(src)
        if xPlayer then xPlayer.removeInventoryItem(item, amount) end
    elseif inv == 'qb' or inv == 'qbx' then
        local player = GetPlayer(src)
        if player then player.Functions.RemoveItem(item, amount) end
    end
end

--- Returns { label, count, metadata } if player has the item, nil if not.
function HasItem(src, item)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        local data = exports.ox_inventory:GetItem(src, item)
        if not data or data.count == 0 then return nil end
        return { label = data.label, count = data.count, metadata = data.metadata }
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        local data = exports['tgiann-inventory']:GetItemByName(src, item)
        if not data or (data.amount or 0) == 0 then return nil end
        return { label = data.label, count = data.amount, metadata = data.info }
    elseif inv == 'codem-inventory' or inv == 'm-inventory' then
        local data = exports[inv]:GetItemByName(src, item)
        if not data or (data.amount or 0) == 0 then return nil end
        return { label = data.label, count = data.amount, metadata = data.info }
    elseif inv == 'qs-inventory' then
        local data = exports['qs-inventory']:GetItemByName(src, item)
        if not data or (data.amount or 0) == 0 then return nil end
        return { label = data.label, count = data.amount, metadata = data.info }
    end
    local count = GetItemCount(src, item)
    return count > 0 and { count = count } or nil
end

--- Returns the full inventory as a table.
function GetPlayerInventory(src)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        local items = exports.ox_inventory:GetInventoryItems(src)
        local data = {}
        if items then
            for k, v in pairs(items) do
                data[k] = v
                data[k].amount = v.count
            end
        end
        return data
    elseif inv == 'tgiann-inventory' or inv == 'tgiann_inventory' then
        return exports['tgiann-inventory']:GetPlayerItems(src) or {}
    elseif inv == 'codem-inventory' or inv == 'm-inventory' then
        return exports[inv]:GetInventory(src) or {}
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:GetInventory(src) or {}
    end
    return {}
end

--- Register a stash (ox_inventory only).
function RegisterStash(name, slots, maxWeight)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        exports.ox_inventory:RegisterStash(name, 'Stash - ' .. name, slots, maxWeight)
        return true
    end
    return false
end
