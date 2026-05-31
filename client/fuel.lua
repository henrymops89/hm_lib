-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Fuel Bridge
-- ══════════════════════════════════════════════════════════════════
---@diagnostic disable: undefined-global

--- Returns the fuel level (0-100) of a vehicle entity.
function GetFuel(veh)
    local fuel = exports.hm_lib:GetFuelSystem()
    if fuel == 'ox_fuel' then
        return Entity(veh).state.fuel
    elseif fuel ~= 'none' then
        return exports[fuel]:GetFuel(veh)
    end
    return GetVehicleFuelLevel(veh)
end

--- Sets the fuel level (0-100) of a vehicle entity.
function SetFuel(veh, amount)
    local fuel = exports.hm_lib:GetFuelSystem()
    if fuel == 'ox_fuel' then
        Entity(veh).state.fuel = amount
    elseif fuel ~= 'none' then
        exports[fuel]:SetFuel(veh, amount)
    else
        SetVehicleFuelLevel(veh, amount + 0.0)
    end
end

exports('GetFuel', GetFuel)
exports('SetFuel', SetFuel)
