-- ══════════════════════════════════════════════════════════════════
--  HM Lib — Client Target Logic
-- ══════════════════════════════════════════════════════════════════

function AddTargetModel(models, options)
    local TargetSystem = exports['hm_lib']:GetTargetSystem()
    if TargetSystem == 'ox_target' then
        exports.ox_target:addModel(models, options)
    elseif TargetSystem == 'qb-target' or TargetSystem == 'bt-target' or TargetSystem == 'meta_target' then
        local system = TargetSystem == 'qb-target' and 'qb-target' or TargetSystem
        exports[system]:AddTargetModel(models, { options = options, distance = options[1].distance or 2.5 })
    elseif TargetSystem == 'qtarget' then
        exports.qtarget:AddTargetModel(models, { options = options, distance = options[1].distance or 2.5 })
    else
        -- Fallback: Use distance check and TextUI in a thread
        CreateThread(function()
            local modelHashes = {}
            for _, m in ipairs(models) do modelHashes[joaat(m)] = true end

            while true do
                local sleep = 1000
                local playerPos = GetEntityCoords(cache.ped)
                local entities = GetGamePool('CPed')
                local found = false
                for _, ent in ipairs(entities) do
                    if modelHashes[GetEntityModel(ent)] then
                        local dist = #(playerPos - GetEntityCoords(ent))
                        if dist < 2.5 then
                            sleep = 0
                            found = true
                            lib.showTextUI('[E] ' .. (options[1].label or 'Interagieren'))
                            if IsControlJustPressed(0, 38) then
                                if options[1].onSelect then options[1].onSelect({ entity = ent }) end
                            end
                            break
                        end
                    end
                end
                if not found then lib.hideTextUI() end
                Wait(sleep)
            end
        end)
    end
end

function AddTargetEntity(entity, options)
    local TargetSystem = exports['hm_lib']:GetTargetSystem()
    if TargetSystem == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif TargetSystem == 'qb-target' or TargetSystem == 'bt-target' or TargetSystem == 'meta_target' then
        local system = TargetSystem == 'qb-target' and 'qb-target' or TargetSystem
        exports[system]:AddTargetEntity(entity, { options = options, distance = options[1].distance or 2.5 })
    elseif TargetSystem == 'qtarget' then
        exports.qtarget:AddTargetEntity(entity, { options = options, distance = options[1].distance or 2.5 })
    else
        -- Fallback: Simplistic interaction for entities with 3D Marker
        CreateThread(function()
            local opt = options[1]
            local label = opt.label or 'Interagieren'
            local distance = opt.distance or 2.5

            while DoesEntityExist(entity) do
                local sleep = 500
                local pPos = GetEntityCoords(cache.ped)
                local ePos = GetEntityCoords(entity)
                local dist = #(pPos - ePos)

                -- Render 3D Marker if close (visual aid)
                if dist < 15.0 then
                    sleep = 0
                    DrawMarker(2, ePos.x, ePos.y, ePos.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 150, false, true, 2, nil, nil, false)
                end

                if dist < distance then
                    sleep = 0
                    lib.showTextUI('[E] ' .. label)
                    if IsControlJustPressed(0, 38) then
                        if opt.onSelect then opt.onSelect({ entity = entity }) end
                    end
                else
                    lib.hideTextUI()
                end

                Wait(sleep)
            end
            lib.hideTextUI()
        end)
    end
end

function RemoveTarget(handle, name)
    local TargetSystem = exports['hm_lib']:GetTargetSystem()
    if TargetSystem == 'ox_target' then
        if name then
            exports.ox_target:removeLocalEntity(handle, name)
        else
            exports.ox_target:removeLocalEntity(handle)
        end
    elseif TargetSystem == 'qb-target' then
        if name then
            exports['qb-target']:RemoveTargetEntity(handle, name)
        else
            exports['qb-target']:RemoveTargetEntity(handle)
        end
    end
end

function RemoveModelTarget(models, names)
    local TargetSystem = exports['hm_lib']:GetTargetSystem()
    if TargetSystem == 'ox_target' then
        if type(models) ~= 'table' then models = { models } end
        exports.ox_target:removeModel(models, names)
    end
end
