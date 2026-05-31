-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Callback Bridge
-- ══════════════════════════════════════════════════════════════════
---@diagnostic disable: undefined-global

local clientCallbacks = {}

local function RandomKey()
    return math.random(100000, 999999) .. '_' .. GetGameTimer()
end

--- Call a registered server callback and get the result via cb.
function TriggerServerCallback(name, cb, ...)
    local key = RandomKey()
    clientCallbacks[key] = cb
    TriggerServerEvent('hm_lib:serverCallback', name, key, ...)
end

--- Register a client-side callback (callable from server).
function RegisterClientCallback(name, cb)
    clientCallbacks['reg_' .. name] = cb
end

-- ── Internal net events ─────────────────────────────────────────

RegisterNetEvent('hm_lib:serverReturn', function(key, result)
    local cb = clientCallbacks[key]
    if cb then
        cb(result)
        clientCallbacks[key] = nil
    end
end)

RegisterNetEvent('hm_lib:callbackMissing', function(key, name)
    print(('[hm_lib] Server callback "%s" is not registered'):format(name))
    clientCallbacks[key] = nil
end)

RegisterNetEvent('hm_lib:clientCallback', function(name, key, ...)
    local cb = clientCallbacks['reg_' .. name]
    if not cb then
        print(('[hm_lib] RegisterClientCallback "%s" not found'):format(name))
        return
    end
    local result = cb(...)
    TriggerServerEvent('hm_lib:clientReturn:' .. key, result)
end)

exports('TriggerServerCallback',   TriggerServerCallback)
exports('RegisterClientCallback',  RegisterClientCallback)
