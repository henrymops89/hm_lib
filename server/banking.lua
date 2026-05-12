-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Server Banking Logic
-- ══════════════════════════════════════════════════════════════════

function GetMoney(src)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return 0 end

    if bank == 'esx' then
        return player.getAccount('bank').money
    elseif bank == 'qb' or bank == 'qbx' then
        return player.Functions.GetMoney('bank')
    elseif bank == 'renewed-banking' then
        return exports['Renewed-Banking']:getAccountMoney(GetIdentifier(src))
    elseif bank == 'wasabi_banking' then
        return exports['wasabi_banking']:GetBalance(src)
    elseif bank == 'okokBanking' then
        return exports.okokBanking:GetAccountMoney(src)
    elseif bank == 'new_banking' then
        return exports.new_banking:getAccountMoney(src)
    elseif bank == 'pepe-banking' then
        return exports['pepe-banking']:GetPlayerBank(src)
    end
    return 0
end

function AddMoney(src, amount)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return end

    if bank == 'esx' then
        player.addAccountMoney('bank', amount)
    elseif bank == 'qb' or bank == 'qbx' then
        player.Functions.AddMoney('bank', amount)
    elseif bank == 'renewed-banking' then
        exports['Renewed-Banking']:addAccountMoney(GetIdentifier(src), amount)
    elseif bank == 'wasabi_banking' then
        exports['wasabi_banking']:AddMoney('bank', src, amount)
    elseif bank == 'okokBanking' then
        exports.okokBanking:AddMoney(src, amount)
    elseif bank == 'new_banking' then
        exports.new_banking:addMoney(src, amount)
    elseif bank == 'pepe-banking' then
        exports['pepe-banking']:AddBank(src, amount)
    end
end

function RemoveMoney(src, amount)
    local bank = exports['hm_lib']:GetBanking()
    local player = GetPlayer(src)
    if not player then return end

    if bank == 'esx' then
        player.removeAccountMoney('bank', amount)
    elseif bank == 'qb' or bank == 'qbx' then
        player.Functions.RemoveMoney('bank', amount)
    elseif bank == 'renewed-banking' then
        exports['Renewed-Banking']:removeAccountMoney(GetIdentifier(src), amount)
    elseif bank == 'wasabi_banking' then
        exports['wasabi_banking']:RemoveMoney('bank', src, amount)
    elseif bank == 'okokBanking' then
        exports.okokBanking:RemoveMoney(src, amount)
    elseif bank == 'new_banking' then
        exports.new_banking:removeMoney(src, amount)
    elseif bank == 'pepe-banking' then
        exports['pepe-banking']:RemoveBank(src, amount)
    end
end

-- ── Society ──────────────────────────────────────────────────────

function GetSocietyMoney(society)
    local bank = exports['hm_lib']:GetBanking()
    local framework = exports['hm_lib']:GetFramework()

    if bank == 'wasabi_banking' then
        return exports['wasabi_banking']:GetAccountBalance(society, 'society') or 0
    elseif bank == 'renewed-banking' then
        return exports['Renewed-Banking']:getAccountMoney(society) or 0
    end

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
    local bank = exports['hm_lib']:GetBanking()
    local framework = exports['hm_lib']:GetFramework()

    if bank == 'wasabi_banking' then
        exports['wasabi_banking']:AddMoney('society', society, amount)
        return
    elseif bank == 'renewed-banking' then
        exports['Renewed-Banking']:addAccountMoney(society, amount)
        return
    end

    if framework == 'esx' then
        TriggerEvent('esx_society:depositMoney', society, amount)
    elseif framework == 'qb' or framework == 'qbx' then
        exports['qb-management']:AddMoney(society, amount)
    end
end

function RemoveSocietyMoney(society, amount)
    local bank = exports['hm_lib']:GetBanking()
    local framework = exports['hm_lib']:GetFramework()

    if bank == 'wasabi_banking' then
        exports['wasabi_banking']:RemoveMoney('society', society, amount)
        return
    elseif bank == 'renewed-banking' then
        exports['Renewed-Banking']:removeAccountMoney(society, amount)
        return
    end

    if framework == 'esx' then
        TriggerEvent('esx_society:withdrawMoney', society, amount)
    elseif framework == 'qb' or framework == 'qbx' then
        exports['qb-management']:RemoveMoney(society, amount)
    end
end
