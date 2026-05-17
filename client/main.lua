-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Base
-- ══════════════════════════════════════════════════════════════════

-- (Functions moved to modular files)

-- ── GiveWeapon (native — bypasses inventory system entirely) ────

RegisterNetEvent('hm_lib:client:GiveWeapon', function(weaponName, ammo)
    local hash = joaat(weaponName)
    GiveWeaponToPed(cache.ped, hash, ammo or 0, false, true)
    SetCurrentPedWeapon(cache.ped, hash, true)
end)

-- ── Exports ─────────────────────────────────────────────────────

exports('Notify',          Notify)
exports('AddTargetModel',  AddTargetModel)
exports('AddTargetEntity', AddTargetEntity)
exports('RemoveTarget',    RemoveTarget)
