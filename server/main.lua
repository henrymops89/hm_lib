-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Base
--  MopsScripts
-- ══════════════════════════════════════════════════════════════════

local Framework     = nil
local FrameworkName = nil

local function EnsureFramework()
    if FrameworkName then return end
    FrameworkName = exports.hm_lib:GetFramework()
    if FrameworkName == 'esx' then
        Framework = exports['es_extended']:getSharedObject()
    elseif FrameworkName == 'qb' then
        Framework = exports['qb-core']:GetCoreObject()
    elseif FrameworkName == 'qbx' then
        Framework = exports.qbx_core
    end
end

-- ── Identifiers ──────────────────────────────────────────────────

function GetPlayer(src)
    EnsureFramework()
    if FrameworkName == 'esx' then
        return Framework.GetPlayerFromId(src)
    elseif FrameworkName == 'qbx' then
        return exports.qbx_core:GetPlayer(src)
    elseif FrameworkName == 'qb' then
        return Framework.Functions.GetPlayer(src)
    end
    return nil
end

function GetIdentifier(src)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return nil end
    if FrameworkName == 'esx' then
        return player.identifier
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return player.PlayerData.citizenid
    end
    return nil
end

function GetIdentifiers(src)
    local ids = {}
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if id then
            if     id:find('^steam:')   then ids.steam   = id
            elseif id:find('^license2:') then ids.license2 = id
            elseif id:find('^license:') then ids.license  = id
            elseif id:find('^discord:') then ids.discord  = id
            elseif id:find('^live:')    then ids.live     = id
            elseif id:find('^xbl:')     then ids.xbl      = id
            elseif id:find('^fivem:')   then ids.fivem    = id
            elseif id:find('^ip:')      then ids.ip       = id
            end
        end
    end
    return ids
end

function GetDiscordId(src)
    local id = GetIdentifiers(src).discord
    return id and id:gsub('discord:', '') or nil
end

function GetLicenseId(src)
    local id = GetIdentifiers(src).license
    return id and id:gsub('license:', '') or nil
end

function GetSteamId(src)
    local id = GetIdentifiers(src).steam
    return id and id:gsub('steam:', '') or nil
end

function GetPlayerName(src)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return 'Unknown' end
    if FrameworkName == 'esx' then
        return player.getName()
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
    end
    return 'Unknown'
end

function GetPlayerJob(src)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return { name = 'unemployed', label = 'Unemployed', grade = 0, grade_label = 'None' } end

    if FrameworkName == 'esx' then
        return {
            name        = player.job.name,
            label       = player.job.label,
            grade       = player.job.grade,
            grade_label = player.job.grade_label,
        }
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return {
            name        = player.PlayerData.job.name,
            label       = player.PlayerData.job.label,
            grade       = player.PlayerData.job.grade.level,
            grade_label = player.PlayerData.job.grade.name,
        }
    end
    return { name = 'unemployed', label = 'Unemployed', grade = 0, grade_label = 'None' }
end

function HasJob(src, jobList)
    local job = GetPlayerJob(src)
    if type(jobList) == 'string' then
        return job.name == jobList
    elseif type(jobList) == 'table' then
        for _, j in ipairs(jobList) do
            if job.name == j then return true end
        end
    end
    return false
end

-- ── Job Management ────────────────────────────────────────────────

function SetJob(src, jobName, grade)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return false end

    if FrameworkName == 'esx' then
        player.setJob(jobName, grade or 0)
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        player.Functions.SetJob(jobName, grade or 0)
    end
    return true
end

function GetPlayerByIdentifier(identifier)
    EnsureFramework()
    if not identifier or identifier == '' then return nil end

    if FrameworkName == 'esx' then
        return Framework.GetPlayerFromIdentifier(identifier)
    elseif FrameworkName == 'qbx' then
        return exports.qbx_core:GetPlayerByCitizenId(identifier)
    elseif FrameworkName == 'qb' then
        return Framework.Functions.GetPlayerByCitizenId(identifier)
    end
    return nil
end

function GetPlayerSource(identifier)
    local player = GetPlayerByIdentifier(identifier)
    if not player then return nil end

    if FrameworkName == 'esx' then
        return player.source
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return player.PlayerData.source
    end
    return nil
end

function GetJobs()
    EnsureFramework()
    if FrameworkName == 'esx' then
        return Framework.GetJobs and Framework.GetJobs() or {}
    elseif FrameworkName == 'qbx' then
        return exports.qbx_core:GetJobs()
    elseif FrameworkName == 'qb' then
        return Framework.Shared and Framework.Shared.Jobs or {}
    end
    return {}
end

function GetGangs()
    EnsureFramework()
    if FrameworkName == 'qbx' then
        return exports.qbx_core:GetGangs()
    elseif FrameworkName == 'qb' then
        return Framework.Shared and Framework.Shared.Gangs or {}
    end
    return {}
end

-- ── Notify (Server to Client) ────────────────────────────────────

function NotifyServer(src, type, msg, title, duration)
    TriggerClientEvent('hm_lib:client:Notify', src, type, msg, title, duration)
end

function GiveWeapon(src, weaponName, ammo)
    local inv = exports['hm_lib']:GetInventory()
    if inv == 'ox_inventory' then
        -- ox_inventory manages weapon equipping through its own UI (F2 → use item).
        -- Any native give here would desync its internal state.
        return
    end
    -- All other inventories: give weapon natively via client event
    TriggerClientEvent('hm_lib:client:GiveWeapon', src, weaponName, ammo or 0)
end

-- ── Usable Items ────────────────────────────────────────────────

function RegisterUsableItem(name, cb)
    EnsureFramework()
    print(('[HM Lib] Registering usable item: %s (%s)'):format(name, FrameworkName))

    if FrameworkName == 'esx' then
        Framework.RegisterUsableItem(name, cb)
        if Framework.AddItems then
            local label = name:gsub('_', ' '):gsub('^%l', string.upper)
            Framework.AddItems({{ name = name, label = label, weight = 1 }})
        end
    elseif FrameworkName == 'qb' then
        Framework.Functions.CreateUseableItem(name, cb)
    elseif FrameworkName == 'qbx' then
        exports.qbx_core:CreateUseableItem(name, cb)
    end
end

-- ── Metadata & Permissions ───────────────────────────────────────

function SetMetadata(src, key, value)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return false end
    if FrameworkName == 'esx' then
        player.setMeta(key, value)
    elseif FrameworkName == 'qb' then
        player.Functions.SetMetaData(key, value)
    elseif FrameworkName == 'qbx' then
        player.Functions.SetMetaData(key, value)
    end
    return true
end

function GetMetadata(src, key)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return nil end
    if FrameworkName == 'esx' then
        return player.getMeta(key)
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return player.PlayerData.metadata and player.PlayerData.metadata[key] or nil
    end
    return nil
end

function HasPermission(src, permission)
    EnsureFramework()
    local player = GetPlayer(src)
    if not player then return false end
    if FrameworkName == 'esx' then
        return player.getGroup() == permission
    elseif FrameworkName == 'qb' or FrameworkName == 'qbx' then
        return IsPlayerAceAllowed(src, permission)
    end
    return IsPlayerAceAllowed(src, permission)
end

-- ── Exports ─────────────────────────────────────────────────────

exports('GetPlayer',              GetPlayer)
exports('GetIdentifier',          GetIdentifier)
exports('GetPlayerName',          GetPlayerName)
exports('GetPlayerJob',           GetPlayerJob)
exports('HasJob',                 HasJob)
exports('SetJob',                 SetJob)
exports('GetPlayerByIdentifier',  GetPlayerByIdentifier)
exports('GetPlayerSource',        GetPlayerSource)
exports('GetJobs',                GetJobs)
exports('GetGangs',               GetGangs)
exports('GiveWeapon',             GiveWeapon)
exports('GetItemCount',       GetItemCount)
exports('AddItem',            AddItem)
exports('RemoveItem',         RemoveItem)
exports('GetMoney',           GetMoney)
exports('AddMoney',           AddMoney)
exports('RemoveMoney',        RemoveMoney)
exports('GetSocietyMoney',    GetSocietyMoney)
exports('AddSocietyMoney',    AddSocietyMoney)
exports('RemoveSocietyMoney', RemoveSocietyMoney)
exports('NotifyServer',       NotifyServer)
exports('RegisterUsableItem', RegisterUsableItem)
exports('SetMetadata',        SetMetadata)
exports('GetMetadata',        GetMetadata)
exports('HasPermission',      HasPermission)

print('^2[HM Lib] Server-Side started — framework detection deferred until first use.^7')

