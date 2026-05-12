-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Player Data
-- ══════════════════════════════════════════════════════════════════

local PlayerData = {}

--- Fetch and Sync Player Data
function RefreshPlayerData()
    local framework = exports.hm_lib:GetFramework()

    if framework == 'esx' then
        local xPlayer = exports['es_extended']:getSharedObject().PlayerData
        if not xPlayer then return PlayerData end
        
        local firstName = xPlayer.firstName or xPlayer.firstname or ''
        local lastName = xPlayer.lastName or xPlayer.lastname or ''
        local fullName = (firstName ~= '' or lastName ~= '') and (firstName .. ' ' .. lastName) or GetPlayerName(PlayerId())

        PlayerData = {
            identifier      = xPlayer.identifier,
            name            = fullName,
            job             = xPlayer.job and xPlayer.job.name or 'unemployed',
            job_label       = xPlayer.job and xPlayer.job.label or 'Unemployed',
            grade           = xPlayer.job and xPlayer.job.grade or 0,
            grade_label     = xPlayer.job and xPlayer.job.grade_label or '',
            inventory       = xPlayer.inventory or {},
            money           = xPlayer.money or 0,
            accounts        = xPlayer.accounts or {},
            metadata        = xPlayer.metadata or {},
        }
    elseif framework == 'qbx' then
        local pData = exports.qbx_core:GetPlayerData()
        if not pData then return PlayerData end

        local firstName = pData.charinfo and pData.charinfo.firstname or ''
        local lastName = pData.charinfo and pData.charinfo.lastname or ''
        local fullName = (firstName ~= '' or lastName ~= '') and (firstName .. ' ' .. lastName) or GetPlayerName(PlayerId())

        PlayerData = {
            identifier  = pData.citizenid,
            name        = fullName,
            job         = pData.job and pData.job.name or 'unemployed',
            job_label   = pData.job and pData.job.label or 'Unemployed',
            grade       = pData.job and pData.job.grade and pData.job.grade.level or 0,
            grade_label = pData.job and pData.job.grade and pData.job.grade.name or '',
            inventory   = pData.items or {},
            money       = pData.money and pData.money['cash'] or 0,
            accounts    = pData.money or {},
            metadata    = pData.metadata or {},
        }
    elseif framework == 'qb' then
        local pData = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
        if not pData then return PlayerData end

        local firstName = pData.charinfo and pData.charinfo.firstname or ''
        local lastName = pData.charinfo and pData.charinfo.lastname or ''
        local fullName = (firstName ~= '' or lastName ~= '') and (firstName .. ' ' .. lastName) or GetPlayerName(PlayerId())

        PlayerData = {
            identifier      = pData.citizenid,
            name            = fullName,
            job             = pData.job and pData.job.name or 'unemployed',
            job_label       = pData.job and pData.job.label or 'Unemployed',
            grade           = pData.job and pData.job.grade and pData.job.grade.level or 0,
            grade_label     = pData.job and pData.job.grade and pData.job.grade.name or '',
            inventory       = pData.items or {},
            money           = pData.money and pData.money['cash'] or 0,
            accounts        = pData.money or {},
            metadata        = pData.metadata or {},
        }
    else
        PlayerData = {
            identifier = GetPlayerServerId(PlayerId()),
            name       = GetPlayerName(PlayerId()),
            job        = 'unemployed',
            grade      = 0,
        }
    end
    return PlayerData
end

--- Standardized Player Data Export
function GetPlayerData()
    if not next(PlayerData) then RefreshPlayerData() end
    return PlayerData
end

-- ── Events ──────────────────────────────────────────────────────

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    RefreshPlayerData()
end)

RegisterNetEvent('esx:setJob', function(job)
    RefreshPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    RefreshPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    RefreshPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

--- Get Item Count
function GetItemCount(pedOrItem, itemNameOrNil)
    -- Handle arguments (ped, item) vs (item)
    local itemName = type(pedOrItem) == 'string' and pedOrItem or itemNameOrNil
    if not itemName then return 0 end

    local inv = exports.hm_lib:GetInventory()
    local count = 0

    if inv == 'ox_inventory' then
        count = exports.ox_inventory:Search('count', itemName) or 0
    else
        local pData = GetPlayerData()
        if pData and pData.inventory then
            for _, item in pairs(pData.inventory) do
                if item.name == itemName then
                    -- ESX uses 'count', QB uses 'amount'
                    count = count + (item.count or item.amount or 0)
                end
            end
        end
    end

    return count
end

exports('GetPlayerData', GetPlayerData)
exports('RefreshPlayerData', RefreshPlayerData)
exports('GetItemCount', GetItemCount)
