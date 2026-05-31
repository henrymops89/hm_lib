fx_version 'cerulean'
game 'gta5'

name 'hm_lib'
description 'Centralized Library for HM Resources — MopsScripts'
version '1.2.0'
author 'MopsScripts'

dependencies {
    'ox_lib',
}

files {
    'imports.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/framework.lua',
    'shared/commands.lua',
    'shared/utils.lua'
}

client_scripts {
    'client/target.lua',
    'client/notify.lua',
    'client/progress.lua',
    'client/player.lua',
    'client/garage.lua',
    'client/doors.lua',
    'client/fuel.lua',
    'client/callbacks.lua',
    'client/main.lua'
}

server_scripts {
    'server/inventory.lua',
    'server/banking.lua',
    'server/doors.lua',
    'server/webhook.lua',
    'server/callbacks.lua',
    'server/main.lua'
}

lua54 'yes'

exports {
    -- Shared
    'GetFramework',
    'GetInventory',
    'GetBanking',
    'GetTargetSystem',
    'GetGarageSystem',
    'GetVehicleKeysSystem',
    'GetDoorLockSystem',
    'GetFuelSystem',
    'GetVersion',
    'CheckMinVersion',
    'GetInteractionMode',
    'IsResourceStarted',
    'CreateCommand',
    'FormatCurrency',
    'GetDistance',
    'DeepCopy',

    -- Client
    'Notify',
    'ProgressBar',
    'GetPlayerData',
    'RefreshPlayerData',
    'GetItemCount',
    'AddTargetModel',
    'AddTargetEntity',
    'RemoveTarget',
    'RemoveModelTarget',
    'GiveJobVehicleKeys',
    'CacheJobVehicle',
    'SetDoorState',
    'GetDoorState',
    'TriggerServerCallback',
    'RegisterClientCallback',
    'GetFuel',
    'SetFuel',
    'AddGlobalVehicle',
    'AddGlobalPlayer',
}

server_exports {
    'GetPlayer',
    'GetIdentifier',
    'GetPlayerName',
    'GetPlayerJob',
    'HasJob',
    'SetJob',
    'GetPlayerByIdentifier',
    'GetPlayerSource',
    'GetJobs',
    'GetGangs',
    'GiveWeapon',
    'GetItemCount',
    'AddItem',
    'RemoveItem',
    'GetMoney',
    'AddMoney',
    'RemoveMoney',
    'GetSocietyMoney',
    'AddSocietyMoney',
    'RemoveSocietyMoney',
    'NotifyServer',
    'RegisterUsableItem',
    'SetDoorState',
    'LockdownBuilding',
    'SendWebhook',
    'SendDiscordLog',
    'SendStaffAlert',
    'GetIdentifiers',
    'GetDiscordId',
    'GetLicenseId',
    'GetSteamId',
    'RegisterCallback',
    'TriggerClientCallback',
    'SetMetadata',
    'GetMetadata',
    'HasPermission',
    'HasItem',
    'GetPlayerInventory',
    'RegisterStash'
}
