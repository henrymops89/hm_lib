-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Garage / Vehicle Keys Bridge
-- ══════════════════════════════════════════════════════════════════
---@diagnostic disable: undefined-global

--- Give keys for a job/department vehicle to the local player.
--- Bridges to the installed vehicle-keys resource automatically.
---@param plate  string  Vehicle plate (trimmed, uppercase)
---@param vehicle number Entity handle
function GiveJobVehicleKeys(plate, vehicle)
    local keysSystem = exports.hm_lib:GetVehicleKeysSystem()

    if keysSystem == 'cd_garage' then
        TriggerEvent('cd_garage:AddKeys', plate)
        SetVehicleDoorsLocked(vehicle, 1)

    elseif keysSystem == 'qb-vehiclekeys' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
        SetVehicleDoorsLocked(vehicle, 1)

    elseif keysSystem == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(plate)
        SetVehicleDoorsLocked(vehicle, 1)

    elseif keysSystem == 'wasabi_carkeys' then
        exports['wasabi_carkeys']:GiveKey(plate)
        SetVehicleDoorsLocked(vehicle, 1)

    elseif keysSystem == 'renewed-vehiclekeys' then
        exports['Renewed-Vehiclekeys']:GiveKey(plate)
        SetVehicleDoorsLocked(vehicle, 1)

    else
        -- No keys system: just unlock so the player can drive
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehicleDoorsLocked(vehicle, 1)
    end
end

exports('GiveJobVehicleKeys', GiveJobVehicleKeys)

--- Notify the installed garage system that a job vehicle was spawned.
--- Must be called CLIENT-side so the garage system receives the correct player source.
---@param plate      string   Vehicle plate (trimmed, uppercase)
---@param modelName  string   Model spawn name (e.g. 'police')
function CacheJobVehicle(plate, modelName)
    local garageSystem = exports.hm_lib:GetGarageSystem()

    if garageSystem == 'cd_garage' then
        TriggerServerEvent('cd_garage:AddKeysOwnedVehicle', plate, (modelName or ''):lower())

    elseif garageSystem == 'qs-advancedgarages' then
        -- qs-advancedgarages handles persistence server-side; nothing needed client-side
    elseif garageSystem == 'qb-garages' then
        -- qb-garages doesn't track job vehicles separately; nothing needed
    end
    -- Other systems: no job-vehicle caching required
end

exports('CacheJobVehicle', CacheJobVehicle)
