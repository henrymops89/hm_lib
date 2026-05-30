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
function Fr.GetTargetSystem()       return lib:GetTargetSystem() end
function Fr.GetInteractionMode()    return lib:GetInteractionMode() end
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

-- ── Target Bridge (Target) ──────────────────────────────────────

Target = {}

if not isServer then
    function Target.AddModel(models, options)       return lib:AddTargetModel(models, options) end
    function Target.AddEntity(entity, options)      return lib:AddTargetEntity(entity, options) end
    function Target.Remove(handle, name)            return lib:RemoveTarget(handle, name) end
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
