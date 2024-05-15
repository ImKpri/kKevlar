ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent("Kevlar:Remove")
AddEventHandler("Kevlar:Remove", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        -- Ajoutez ici la logique pour supprimer le Kevlar du joueur, par exemple, en retirant l'objet de son inventaire.
        -- Par exemple, si le Kevlar est un item avec le nom "kevlar_item", vous pouvez utiliser :
      --xPlayer.removeInventoryItem("armor", 1)
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local ped = GetPlayerPed(src) -- Obtient le ped du joueur qui quitte

    if GetPedArmour(ped) == 100 then
        TriggerEvent('esx:addInventoryItem', src, 'kevlarItem', 1) -- Utilise l'ID du joueur (src) pour ajouter l'objet à son inventaire
        TriggerEvent('skinchanger:loadClothes', src, { ["bproof_1"] = 0, ["bproof_2"] = 0 }) -- Change les vêtements du joueur
    end
end)

ESX.RegisterUsableItem('armor', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if CfgKevlar.UseItem then
    if xPlayer then
        -- Vérifiez si le joueur a l'item "kevlar_item" dans son inventaire
        local kevlarItem = xPlayer.getInventoryItem("armor")
        
        if kevlarItem and kevlarItem.count > 0 then
            TriggerClientEvent("Kevlar:ChechTest", source)
            xPlayer.removeInventoryItem("armor", 1)
            TriggerClientEvent("Kevlar:RemoveToClient", source)
            
        else
            -- Si le joueur n'a pas l'item, vous pouvez afficher un message d'erreur
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas de Kevlar.")
            TriggerClientEvent("Kevlar:ChechTest", source)
        end
        else
            print('tu peux pas')
    end
    end
end)

RegisterServerEvent("Kevlar:Add")
AddEventHandler("Kevlar:Add", function(speed)
    local xPlayer = ESX.GetPlayerFromId(source)
    if CfgKevlar.UseTrigger then
    if xPlayer then
        -- Vérifiez si le joueur a l'item "kevlar_item" dans son inventaire
        local kevlarItem = xPlayer.getInventoryItem("armor")
        
        if kevlarItem and kevlarItem.count > 0 then
            TriggerClientEvent("Kevlar:ChechTest", source)
            xPlayer.removeInventoryItem("armor", 1)
            TriggerClientEvent("Kevlar:RemoveToClient", source)
            
        else
            -- Si le joueur n'a pas l'item, vous pouvez afficher un message d'erreur
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas de Kevlar.")
            TriggerClientEvent("Kevlar:ChechTest", source)
        end
        else
            print('tu peux pas')
    end
    end
end)

RegisterServerEvent('esx_armour:armorremove')
AddEventHandler('esx_armour:armorremove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('armor', 1)
end)

RegisterServerEvent('esx_armour:addwhenmax')
AddEventHandler('esx_armour:addwhenmax', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('armor', 1)
end)
