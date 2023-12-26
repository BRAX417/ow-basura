ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local zoneCreated = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) 

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local closestEntity = 0
        local closestEntityCoords = nil

        for _, prop in ipairs(Config.Prop) do
            local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 2.0, GetHashKey(prop), false, false, false)
            if entity ~= 0 then
                closestEntity = entity
                closestEntityCoords = GetEntityCoords(closestEntity)
                break
            end
        end

        if closestEntity ~= 0 and not zoneCreated and closestEntityCoords then
            exports.ox_target:addBoxZone({
                coords = vector3(closestEntityCoords.x, closestEntityCoords.y, closestEntityCoords.z + 1),
                size = vector3(2, 2, 2),
                rotation = 0,
                debug = false,
                drawSprite = true,
                distance = 2.0,
                options = {
                    {
                        name = 'search_trash',
                        event = 'esx:buscarbasura',
                        args = {},
                        icon = 'fas fa-trash',
                        label = 'Buscar en la basura',
                    }
                }
            })

            zoneCreated = true
        end
    end
end)

RegisterNetEvent('esx:buscarbasura')
AddEventHandler('esx:buscarbasura', function()
    local playerPed = PlayerPedId()

    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(playerPed)

    local item = Config.Items[math.random(#Config.Items)]
    local quantity = math.random(1, 3)

    TriggerServerEvent('esx:darItem', item, quantity)
    ESX.ShowNotification('Has encontrado ~y~' .. quantity .. '~s~ ~g~' .. Config.ItemNames[item]) 
end)

RegisterNetEvent('esx:darItem')
AddEventHandler('esx:darItem', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem(item, quantity) then
        xPlayer.addInventoryItem(item, quantity)
    else
        xPlayer.showNotification('No tienes suficiente espacio en tu inventario')
    end
end)






