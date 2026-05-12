-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Notifications
-- ══════════════════════════════════════════════════════════════════

function Notify(type, msg, title, duration)
    local title = title or 'Information'
    local duration = duration or 5000
    local type = type or 'info'

    -- ox_lib is mandatory, so use it as primary
    if GetResourceState('ox_lib') == 'started' then
        lib.notify({
            title = title,
            description = msg,
            type = type,
            duration = duration
        })
        return
    end

    -- Fallback for specific frameworks if ox_lib is somehow missing during transition
    if GetResourceState('qb-core') == 'started' then
        TriggerEvent('QBCore:Notify', msg, type, duration)
    elseif GetResourceState('es_extended') == 'started' then
        TriggerEvent('esx:showNotification', msg)
    else
        -- Standard GTA Notification
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(false, false)
    end
end

RegisterNetEvent('hm_lib:client:Notify', function(type, msg, title, duration)
    Notify(type, msg, title, duration)
end)
