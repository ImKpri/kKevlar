ESX = nil
local Kevlared = false

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

_print = print
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion


Citizen.CreateThread(function()
    while true do
		local wait = 1000
    	local ped = PlayerPedId()

        if IsPedArmed(ped, 6) then
			wait = 0
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
        end
		Citizen.Wait(wait)
    end
end)


local function Ragdoll(timer)
    local ragdoll = true

    SetTimeout(timer, function()
        ragdoll = false
    end)

    CreateThread(function()
        while true do

            if ragdoll then
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                ResetPedRagdollTimer(PlayerPedId())
            else
                break
            end
            
            Wait(1)
        end
    end)
end

AddEventHandler("entityDamaged", function(player)
    local ped = PlayerPedId()
    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
        TriggerEvent("skinchanger:getSkin", function(skina)
            if player == ped then
                if GetPedArmour(ped) ~= 0 then
                    Kevlared = true
                elseif GetPedArmour(ped) <= 0 and Kevlared then
                    ESX.ShowNotification("Votre Kevlar s'est brisé")
                    if skin.sex == 0 then
                        TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                    else
                        TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                    end
                    ClearTimecycleModifier()
                    SetTimecycleModifier("hud_def_blur")
                    Ragdoll(3000)
                    Wait(3000)
                    ClearTimecycleModifier()
                   -- TriggerServerEvent('esx_armour:armorremove')
                    --TriggerServerEvent("Kevlar:Remove")
                    Kevlared = false
                elseif GetPedArmour(ped) <= 25 and Kevlared then
                    --SetEntityMaxSpeed(ped, 6.0)
                elseif GetPedArmour(ped) <= 50 and Kevlared then
                    -- SetEntityMaxSpeed(ped, 5.0)
                end
            end
        end)
    end)
end)


RegisterNetEvent("Kevlar:Add2")
AddEventHandler("Kevlar:Add2", function(speed)
    if not bloquertouchejojo then
        local ped = PlayerPedId()
        local model2 = GetEntityModel(GetPlayerPed(-1))

        ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
            TriggerEvent("skinchanger:getSkin", function(skina)
                ExecuteCommand("me est en train de mettre un gilet pare-balles")
                
                ESX.Streaming.RequestAnimDict('clothingshirt', function()
                    TaskPlayAnim(ped, 'clothingshirt', 'try_shirt_positive_d', 8.0, -8, -1, 49, 0, 0, 0, 0)
                    
                    if skin.sex == 0 then
                        TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 18, ["bproof_2"] = 0 })
                    else
                        TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 11, ["bproof_2"] = 1 })
                    end

                    Citizen.Wait(1000) -- Attendre un court instant pour permettre la mise en place du gilet

                    if GetPedArmour(plyPed) == 100 then
                        SetPedArmour(plyPed, 0)
                    else
                        SetPedArmour(plyPed, 100)
                        ClearPedBloodDamage(plyPed)
                        ResetPedVisibleDamage(plyPed)
                        ClearPedLastWeaponDamage(plyPed)
                        ResetPedMovementClipset(plyPed, 0.0)

                        TriggerServerEvent('esx_armour:armorremove')

                        ESX.ShowNotification("Tu as utilisé ton gilet pare-balles")
                        FreezeEntityPosition(PlayerPedId(), false)
                    end

                    Citizen.Wait(4000)
                    ClearPedSecondaryTask(ped)
                    FreezeEntityPosition(PlayerPedId(), false)
                end)
            end)
        end)
    end
    Kevlared = true
end)



local kevlarItem = 'armor'

RegisterNetEvent("Kevlar:RemoveToClient")
AddEventHandler("Kevlar:RemoveToClient", function()
   -- SetEntityMaxSpeed(PlayerPedId(), 7.0)
    Kevlared = false
    TriggerEvent('Kevlar:Add2')
end)

RegisterNetEvent("Kevlar:ChechTest")
AddEventHandler("Kevlar:ChechTest", function()
    local plyPed = PlayerPedId()
    local ped = PlayerPedId()
    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
        TriggerEvent("skinchanger:getSkin", function(skina)
            if GetPedArmour(plyPed) == 100 then
          ExecuteCommand("me est en train de retirer son gilet pare-balles")
                
                ESX.Streaming.RequestAnimDict('clothingshirt', function()
                    TaskPlayAnim(ped, 'clothingshirt', 'try_shirt_positive_d', 8.0, -8, -1, 49, 0, 0, 0, 0)
                TriggerServerEvent('esx_armour:addwhenmax')
                
                if skin.sex == 0 then
                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                else
                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                end
                Citizen.Wait(5000) -- Attendre un court instant pour permettre la mise en place du gilet
                ClearPedSecondaryTask(ped)
                SetPedArmour(plyPed, 0)
                 ESX.ShowNotification("Tu as retiré ton gilet pare-balles")
                end)
            end
        end)
    end)
end)
