-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Door Lock Bridge
-- ══════════════════════════════════════════════════════════════════

--- Lock or unlock a door by its unique ID.
--- state: true = locked, false = unlocked
function SetDoorState(doorId, state)
    local doorLock = exports['hm_lib']:GetDoorLockSystem()
    if doorLock == 'cd_doorlock' then
        TriggerEvent('cd_doorlock:SetDoorState_uniqueid', state, doorId)
    elseif doorLock == 'ox_doorlock' then
        exports['ox_doorlock']:setDoorState(doorId, state and 1 or 0)
    end
end

--- Lock or unlock all doors of a building group (cd_doorlock only).
--- state: true = lock all, false = unlock all
function LockdownBuilding(locationGroup, state)
    local doorLock = exports['hm_lib']:GetDoorLockSystem()
    if doorLock == 'cd_doorlock' then
        TriggerEvent('cd_doorlock:LockdownBuilding', locationGroup, state)
    end
end

exports('SetDoorState',      SetDoorState)
exports('LockdownBuilding',  LockdownBuilding)
