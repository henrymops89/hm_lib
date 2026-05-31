-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Callback Bridge
-- ══════════════════════════════════════════════════════════════════
---@diagnostic disable: undefined-global

local serverCallbacks = {}

local function RandomKey()
    return math.random(100000, 999999) .. '_' .. GetGameTimer()
end

--- Register a server-side callback handler.
function RegisterCallback(name, cb)
    serverCallbacks[name] = cb
end

--- Trigger a client-side callback and await the result (blocking).
function TriggerClientCallback(player, name, ...)
    local key    = RandomKey()
    local result = nil
    local done   = false

    TriggerClientEvent('hm_lib:clientCallback', player, name, key, ...)

    RegisterNetEvent('hm_lib:clientReturn:' .. key, function(res)
        result = res
        done   = true
    end)

    local timeout  = GetGameTimer() + 5000
    while not done and GetGameTimer() < timeout do
        Wait(50)
    end

    RemoveEventHandler('hm_lib:clientReturn:' .. key)

    if not done then
        print(('[hm_lib] TriggerClientCallback "%s" timed out'):format(name))
    end
    return result
end

-- ── Internal net events ─────────────────────────────────────────

RegisterNetEvent('hm_lib:serverCallback', function(name, key, ...)
    local src = source
    local cb  = serverCallbacks[name]
    if not cb then
        print(('[hm_lib] RegisterCallback "%s" not found'):format(name))
        TriggerClientEvent('hm_lib:callbackMissing', src, key, name)
        return
    end
    local result = cb(src, ...)
    TriggerClientEvent('hm_lib:serverReturn', src, key, result)
end)

exports('RegisterCallback',       RegisterCallback)
exports('TriggerClientCallback',  TriggerClientCallback)
