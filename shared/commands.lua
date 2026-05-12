-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Unified Commands
-- ══════════════════════════════════════════════════════════════════

--- Unified Command Creation
--- @param name string | string[]
--- @param help string
--- @param params table
--- @param callback function
--- @param group string | table (e.g. 'admin', 'user', 'police')
function CreateCommand(name, help, params, callback, group)
    local framework = exports.hm_lib:GetFramework()
    local names = type(name) == 'table' and name or { name }

    for _, cmdName in ipairs(names) do
        if framework == 'esx' then
            -- ESX Style
            local groupParam = group or 'user'
            exports['es_extended']:RegisterCommand(cmdName, groupParam, function(xPlayer, args, showError)
                callback(xPlayer.source, args, showError)
            end, true, { help = help, arguments = params })

        elseif framework == 'qb' or framework == 'qbx' then
            -- QB Style
            local groupParam = group or 'user'
            local QBCore = exports['qb-core']:GetCoreObject()
            QBCore.Commands.Add(cmdName, help, params, true, function(source, args)
                callback(source, args)
            end, groupParam)
        else
            -- Standalone
            RegisterCommand(cmdName, function(source, args, rawCommand)
                callback(source, args, rawCommand)
            end, false)
        end
    end
end

exports('CreateCommand', CreateCommand)
