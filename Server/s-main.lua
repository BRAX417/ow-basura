RegisterNetEvent('esx:darItem')
AddEventHandler('esx:darItem', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem(item, quantity) then
        xPlayer.addInventoryItem(item, quantity)
    else
        xPlayer.showNotification('No tienes suficiente espacio en tu inventario')
    end
end)