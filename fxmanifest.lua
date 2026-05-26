fx_version 'cerulean'
game 'gta5'

name 'hm_lib'
description 'Centralized Library for HM Resources — MopsScripts'
version '1.1.0'
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
    'client/main.lua'
}

server_scripts {
    'server/inventory.lua',
    'server/banking.lua',
    'server/main.lua'
}

lua54 'yes'

exports {
    -- Shared
    'GetFramework',
    'GetInventory',
    'GetBanking',
    'GetTargetSystem',
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
    'RemoveModelTarget'
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
    'RegisterUsableItem'
}
