-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Progress Bar
-- ══════════════════════════════════════════════════════════════════

function ProgressBar(duration, label, dict, anim, flag)
    local duration = duration or 5000
    local label = label or 'Interagieren...'
    local dict = dict or nil
    local anim = anim or nil
    local flag = flag or 49

    -- ox_lib is mandatory
    if GetResourceState('ox_lib') == 'started' then
        return lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, mouse = false, combat = true },
            anim = { dict = dict, clip = anim, flag = flag }
        })
    end

    -- Bare minimum fallback if ox_lib is missing
    lib.showTextUI('[E] ' .. label)
    Wait(duration)
    lib.hideTextUI()
    return true
end

exports('ProgressBar', ProgressBar)
