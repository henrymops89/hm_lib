-- ══════════════════════════════════════════════════════════════════
--  HM Lib — imports.lua
--  Usage: shared_scripts { '@hm_lib/imports.lua' }
--  Provides Fr., Inv., Target., Utils. globals for consuming resources
-- ══════════════════════════════════════════════════════════════════

local lib = exports.hm_lib
local isServer = IsDuplicityVersion()

-- ── Framework Bridge (Fr) ───────────────────────────────────────

Fr = {}

function Fr.GetFramework()          return lib:GetFramework() end
function Fr.GetInventorySystem()    return lib:GetInventory() end
function Fr.GetBankingSystem()      return lib:GetBanking() end
function Fr.GetTargetSystem()         return lib:GetTargetSystem() end
function Fr.GetGarageSystem()         return lib:GetGarageSystem() end
function Fr.GetVehicleKeysSystem()    return lib:GetVehicleKeysSystem() end
function Fr.GetDoorLockSystem()       return lib:GetDoorLockSystem() end
function Fr.GetVersion()              return lib:GetVersion() end
function Fr.CheckMinVersion(min)      return lib:CheckMinVersion(min) end
function Fr.GetInteractionMode()      return lib:GetInteractionMode() end
function Fr.IsResourceStarted(res)  return lib:IsResourceStarted(res) end

if isServer then
    function Fr.GetPlayer(src)                  return lib:GetPlayer(src) end
    function Fr.GetIdentifier(src)              return lib:GetIdentifier(src) end
    function Fr.GetPlayerName(src)              return lib:GetPlayerName(src) end
    function Fr.GetPlayerJob(src)               return lib:GetPlayerJob(src) end
    function Fr.HasJob(src, jobList)            return lib:HasJob(src, jobList) end
    function Fr.SetJob(src, jobName, grade)     return lib:SetJob(src, jobName, grade) end
    function Fr.GetPlayerByIdentifier(id)       return lib:GetPlayerByIdentifier(id) end
    function Fr.GetPlayerSource(id)             return lib:GetPlayerSource(id) end
    function Fr.GetJobs()                       return lib:GetJobs() end
    function Fr.GetGangs()                      return lib:GetGangs() end
    function Fr.Notify(src, type, msg, title, duration)
        lib:NotifyServer(src, type, msg, title, duration)
    end
    function Fr.AddMoney(src, amount)           return lib:AddMoney(src, amount) end
    function Fr.RemoveMoney(src, amount)        return lib:RemoveMoney(src, amount) end
    function Fr.GetMoney(src)                   return lib:GetMoney(src) end
    function Fr.RegisterUsableItem(name, cb)    return lib:RegisterUsableItem(name, cb) end
else
    function Fr.GetPlayerData()                 return lib:GetPlayerData() end
    function Fr.RefreshPlayerData()             return lib:RefreshPlayerData() end
    function Fr.Notify(type, msg, title, duration)
        lib:Notify(type, msg, title, duration)
    end
end

-- ── Inventory Bridge (Inv) ──────────────────────────────────────

Inv = {}

if isServer then
    function Inv.GetItemCount(src, item)            return lib:GetItemCount(src, item) end
    function Inv.AddItem(src, item, amount, meta)   return lib:AddItem(src, item, amount, meta) end
    function Inv.RemoveItem(src, item, amount, meta) return lib:RemoveItem(src, item, amount, meta) end
    function Inv.HasItem(src, item, amount)
        return (lib:GetItemCount(src, item) or 0) >= (amount or 1)
    end
else
    function Inv.GetItemCount(item)                 return lib:GetItemCount(item) end
    function Inv.HasItem(item, amount)
        return (lib:GetItemCount(item) or 0) >= (amount or 1)
    end
end

-- ── Door Lock Bridge (Doors) ────────────────────────────────────

Doors = {}

if isServer then
    function Doors.SetDoorState(doorId, state)          return lib:SetDoorState(doorId, state) end
    function Doors.LockdownBuilding(locationGroup, state) return lib:LockdownBuilding(locationGroup, state) end
else
    function Doors.SetDoorState(doorId, state)          return lib:SetDoorState(doorId, state) end
    function Doors.GetDoorState(doorId)                 return lib:GetDoorState(doorId) end
end

-- ── Webhook Bridge (Webhook) ────────────────────────────────────

Webhook = {}

if isServer then
    function Webhook.Send(webhook, title, desc, color, fields, thumb, footer)
        return lib:SendWebhook(webhook, title, desc, color, fields, thumb, footer)
    end
    function Webhook.Log(webhook, message, color, author)
        return lib:SendDiscordLog(webhook, message, color, author)
    end
    function Webhook.StaffAlert(webhook, rank, action, player, details)
        return lib:SendStaffAlert(webhook, rank, action, player, details)
    end
end

-- ── Identifier Bridge (Ids) ─────────────────────────────────────

Ids = {}

if isServer then
    function Ids.GetAll(src)     return lib:GetIdentifiers(src) end
    function Ids.GetDiscord(src) return lib:GetDiscordId(src) end
    function Ids.GetLicense(src) return lib:GetLicenseId(src) end
    function Ids.GetSteam(src)   return lib:GetSteamId(src) end
end

-- ── Callback Bridge (Cb) ────────────────────────────────────────

Cb = {}

if isServer then
    function Cb.Register(name, handler)       return lib:RegisterCallback(name, handler) end
    function Cb.TriggerClient(player, name, ...) return lib:TriggerClientCallback(player, name, ...) end
else
    function Cb.Trigger(name, cb, ...)        return lib:TriggerServerCallback(name, cb, ...) end
    function Cb.RegisterClient(name, handler) return lib:RegisterClientCallback(name, handler) end
end

-- ── Target Bridge (Target) ──────────────────────────────────────

Target = {}

if not isServer then
    function Target.AddModel(models, options)          return lib:AddTargetModel(models, options) end
    function Target.AddEntity(entity, options)         return lib:AddTargetEntity(entity, options) end
    function Target.Remove(handle, name)               return lib:RemoveTarget(handle, name) end
    function Target.RemoveModel(models, names)         return lib:RemoveModelTarget(models, names) end
end

-- ── Utils Bridge (Utils) ────────────────────────────────────────

Utils = Utils or {}

function Utils.FormatCurrency(amount, symbol)       return lib:FormatCurrency(amount, symbol) end
function Utils.GetDistance(c1, c2)                   return lib:GetDistance(c1, c2) end
function Utils.DeepCopy(obj)                         return lib:DeepCopy(obj) end
function Utils.CreateCommand(name, help, params, cb, group)
    return lib:CreateCommand(name, help, params, cb, group)
end

-- ── Notify / Progress Shortcuts ─────────────────────────────────

if not isServer then
    function Notify(type, msg, title, duration)
        lib:Notify(type, msg, title, duration)
    end

    function ProgressBar(duration, label, dict, anim, flag)
        return lib:ProgressBar(duration, label, dict, anim, flag)
    end
end
