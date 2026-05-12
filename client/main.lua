-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Base
-- ══════════════════════════════════════════════════════════════════

-- (Functions moved to modular files)

-- ── GiveWeapon (native — bypasses inventory system entirely) ────

---@diagnostic disable-next-line: undefined-global
RegisterNetEvent('hm_lib:client:GiveWeapon', function(weaponName, ammo)
    ---@diagnostic disable-next-line: undefined-global
    local hash = joaat(weaponName)
    ---@diagnostic disable-next-line: undefined-global
    GiveWeaponToPed(cache.ped, hash, ammo or 0, false, true)
    ---@diagnostic disable-next-line: undefined-global
    SetCurrentPedWeapon(cache.ped, hash, true)
end)

-- ── Exports ─────────────────────────────────────────────────────

exports('Notify',          Notify)
exports('ProgressBar',     ProgressBar)
exports('AddTargetModel',  AddTargetModel)
exports('AddTargetEntity', AddTargetEntity)
exports('RemoveTarget',    RemoveTarget)
