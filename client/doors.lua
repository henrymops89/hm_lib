-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Door Lock Bridge
-- ══════════════════════════════════════════════════════════════════
---@diagnostic disable: undefined-global

--- Lock or unlock a door by its unique ID.
--- state: true = locked, false = unlocked
function SetDoorState(doorId, state)
    local doorLock = exports.hm_lib:GetDoorLockSystem()
    if doorLock == 'cd_doorlock' then
        TriggerEvent('cd_doorlock:SetDoorState_uniqueid', state, doorId)
    elseif doorLock == 'ox_doorlock' then
        TriggerEvent('ox_doorlock:setState', doorId, state and 1 or 0)
    end
end

--- Returns true if the door is locked, false if unlocked, nil if unsupported.
function GetDoorState(doorId)
    local doorLock = exports.hm_lib:GetDoorLockSystem()
    if doorLock == 'cd_doorlock' then
        return exports['cd_doorlock']:GetDoorState_uniqueid(doorId)
    elseif doorLock == 'ox_doorlock' then
        local data = exports['ox_doorlock']:getDoorData(doorId)
        return data and data.state == 1 or false
    end
    return nil
end

exports('SetDoorState', SetDoorState)
exports('GetDoorState', GetDoorState)
