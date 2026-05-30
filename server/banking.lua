-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Banking Logic
-- ══════════════════════════════════════════════════════════════════

function GetMoney(src)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return 0 end

    if bank == 'esx' then
        return player.getAccount('bank').money
    elseif bank == 'qb' or bank == 'qbx' or bank == 'qb-banking' then
        return player.Functions.GetMoney('bank')
    end
    return 0
end

function AddMoney(src, amount)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return end

    if bank == 'esx' then
        player.addAccountMoney('bank', amount)
    elseif bank == 'qb' or bank == 'qbx' or bank == 'qb-banking' then
        player.Functions.AddMoney('bank', amount)
    end
end

function RemoveMoney(src, amount)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return end

    if bank == 'esx' then
        player.removeAccountMoney('bank', amount)
    elseif bank == 'qb' or bank == 'qbx' or bank == 'qb-banking' then
        player.Functions.RemoveMoney('bank', amount)
    end
end

-- ── Society ──────────────────────────────────────────────────────

function GetSocietyMoney(society)
    local framework = exports['hm_lib']:GetFramework()

    if framework == 'esx' then
        local result = nil
        TriggerEvent('esx_society:getSocietyMoney', society, function(money) result = money end)
        return result or 0
    elseif framework == 'qb' or framework == 'qbx' then
        return exports['qb-management']:GetAccount(society) or 0
    end
    return 0
end

function AddSocietyMoney(society, amount)
    local framework = exports['hm_lib']:GetFramework()

    if framework == 'esx' then
        TriggerEvent('esx_society:depositMoney', society, amount)
    elseif framework == 'qb' or framework == 'qbx' then
        exports['qb-management']:AddMoney(society, amount)
    end
end

function RemoveSocietyMoney(society, amount)
    local framework = exports['hm_lib']:GetFramework()

    if framework == 'esx' then
        TriggerEvent('esx_society:withdrawMoney', society, amount)
    elseif framework == 'qb' or framework == 'qbx' then
        exports['qb-management']:RemoveMoney(society, amount)
    end
end
