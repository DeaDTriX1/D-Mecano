ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

        ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

function Menuf6Bennys()
    local fBennysf6 = RageUI.CreateMenu("", "Interactions")
    local fBennysf6Sub = RageUI.CreateSubMenu(fBennysf6, "", "Annonces")
    local fBennysf6Sub1 = RageUI.CreateSubMenu(fBennysf6, "", "Interaction véhicule")
    fBennysf6:SetRectangleBanner(150, 0, 0)
    fBennysf6Sub:SetRectangleBanner(150, 0, 0)
    fBennysf6Sub1:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(fBennysf6, not RageUI.Visible(fBennysf6))
    while fBennysf6 do
        Citizen.Wait(0)
            RageUI.IsVisible(fBennysf6, true, true, true, function()

                RageUI.Separator("~y~↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ('Benny\'s'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            TriggerServerEvent('D-Mecano:Facture', GetPlayerName(PlayerPedId()), montant)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("~y~↓ Annonce ↓")

                RageUI.ButtonWithStyle("Passer une annonce", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fBennysf6Sub)

                RageUI.Separator("~r~↓ Missions ↓")

                RageUI.ButtonWithStyle("Commencer une mission",nil, {RightLabel = "→→"}, not cooldown, function(Hovered, Active, Selected)
                    if Selected then 
                        StartMecanoMission()
                        TriggerServerEvent('D-Mecano:Prise')
                        cooldowncool(10000)
                    end
                end)

                RageUI.ButtonWithStyle("Arrêter la mission",nil, {RightLabel = "→→"}, not cooldown, function(Hovered, Active, Selected)
                    if Selected then 
                        StopMission()
                        TriggerServerEvent('D-Mecano:Fin')
                        cooldowncool(10000)
                    end
                end)

                RageUI.Separator("~y~↓ Entretiens ↓")

                RageUI.ButtonWithStyle("Interaction véhicule", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fBennysf6Sub1)

                end, function() 
                end)

                RageUI.IsVisible(fBennysf6Sub, true, true, true, function()
                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fBennys:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fBennys:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fBennys:Perso', msg)
                    end
                end)

                end, function() 
                end)

                RageUI.IsVisible(fBennysf6Sub1, true, true, true, function()
                            RageUI.ButtonWithStyle("🔧 Réparer le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                                if (Selected) then
                            local playerPed = PlayerPedId()
                            local vehicle   = ESX.Game.GetVehicleInDirection()
                            local coords    = GetEntityCoords(playerPed)
                
                            if IsPedSittingInAnyVehicle(playerPed) then
                                ESX.ShowNotification('Veuillez descendre de la voiture.')
                                return
                            end
                
                            if DoesEntityExist(vehicle) then
                                isBusy = true
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                                Citizen.CreateThread(function()
                                    Citizen.Wait(20000)
                
                                    SetVehicleFixed(vehicle)
                                    SetVehicleDeformationFixed(vehicle)
                                    SetVehicleUndriveable(vehicle, false)
                                    SetVehicleEngineOn(vehicle, true, true)
                                    ClearPedTasksImmediately(playerPed)
                
                                    ESX.ShowNotification('Le véhicule est réparer')
                                    isBusy = false
                                end)
                            else
                                ESX.ShowNotification('Aucun véhicule à proximiter')
                            end
                        end
                        end)
                        
                        RageUI.ButtonWithStyle("🧽 Nettoyer véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                local vehicle   = ESX.Game.GetVehicleInDirection()
                                local coords    = GetEntityCoords(playerPed)
                    
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    ESX.ShowNotification('Veuillez sortir de la voiture?')
                                    return
                                end
                    
                                if DoesEntityExist(vehicle) then
                                    isBusy = true
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(10000)
                    
                                        SetVehicleDirtLevel(vehicle, 0)
                                        ClearPedTasksImmediately(playerPed)
                    
                                        ESX.ShowNotification('Voiture néttoyé')
                                        isBusy = false
                                    end)
                                else
                                    ESX.ShowNotification('Aucun véhicule trouvée')
                                    end
                                end
                            end)


                        RageUI.ButtonWithStyle("📞 Appeler un Mécano", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TriggerEvent('knb:mech')
                            end
                        end)

                        RageUI.ButtonWithStyle("👨‍🔧 Crocheter le véhicule", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if Selected then
                                local playerPed = PlayerPedId()
                                local vehicle = ESX.Game.GetVehicleInDirection()
                                local coords = GetEntityCoords(playerPed)
                    
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    RageUI.Popup({message = "<C>Sorter du véhicule"})
                                    return
                                end
                    
                                if DoesEntityExist(vehicle) then
                                    isBusy = true
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(10000)
                    
                                        SetVehicleDoorsLocked(vehicle, 1)
                                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                        ClearPedTasksImmediately(playerPed)
                                        RageUI.Popup({message = "<C>Véhicule dévérouiller"})
                                        isBusy = false
                                    end)
                                else
                                    RageUI.Popup({message = "<C>Pas de véhicule proche"})
                                end
                                cooldowncool(5000)
                            end
                        end)


                        RageUI.ButtonWithStyle("🔧 Réparation Moto/Camion", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                local vehicle   = ESX.Game.GetVehicleInDirection()
                                local coords    = GetEntityCoords(playerPed)

                                if IsPedSittingInAnyVehicle(playerPed) then
                                    ESX.ShowNotification(_U('inside_vehicle'))
                                    return
                                end

                                if DoesEntityExist(vehicle) then
                                    IsBusy = true
                                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                                    Citizen.CreateThread(function()
                                        exports['progressBars']:startUI(20000, "Réparation")
                                        Citizen.Wait(20000)

                                        SetVehicleFixed(vehicle)
                                        SetVehicleDeformationFixed(vehicle)
                                        SetVehicleUndriveable(vehicle, false)
                                        SetVehicleEngineOn(vehicle, true, true)
                                        ClearPedTasksImmediately(playerPed)

                                        ESX.ShowNotification('véhicule ~g~réparé')
                                        IsBusy = false
                                    end)
                                else
                                    ESX.ShowNotification('véhicule ~g~réparé')
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("🔧 Réparation Voiture", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local ped = PlayerPedId()
                                local coords = GetEntityCoords(ped)
                                local veh = ObjectInFront(ped, coords)
                                if DoesEntityExist(veh) then
                                    if IsEntityAVehicle(veh) then
                                SetEntityAsMissionEntity(veh, true, true)
                                TriggerEvent('rMecano:MettiCrick', ped, coords, veh)
                            end
                        end
                            end
                        end)

                        RageUI.ButtonWithStyle("🚚 Mettre Véhicule en Fourriere", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                        ESX.ShowNotification('vehicule ~r~mis en fourrière')
                                        ESX.Game.DeleteVehicle(vehicle)
                                    end
                                else
                                    local vehicle = ESX.Game.GetVehicleInDirection()

                                    if DoesEntityExist(vehicle) then
                                        ESX.Game.DeleteVehicle(vehicle)
                                    else
                                        ESX.ShowNotification('vous devez être ~r~près d\'un véhicule~s~ pour le mettre en fourrière')
                                    end
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("Véhicule sur plateau", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                GetCloseVehi()
                            end
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(playerPed, true)

                                local towmodel = GetHashKey('flatbed')
                                local isVehicleTow = IsVehicleModel(vehicle, towmodel)

                                if isVehicleTow then
                                    local targetVehicle = ESX.Game.GetVehicleInDirection()

                                    if CurrentlyTowedVehicle == nil then
                                        if targetVehicle ~= 0 then
                                            if not IsPedInAnyVehicle(playerPed, true) then
                                                if vehicle ~= targetVehicle then
                                                    AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                                    CurrentlyTowedVehicle = targetVehicle
                                                    ESX.ShowNotification('Véhicule Attaché avec succés')

                                                    if NPCOnJob then
                                                        if NPCTargetTowable == targetVehicle then
                                                            ESX.ShowNotification(_U('please_drop_off'))
                                                            Config2.Zones.VehicleDelivery.Type = 1

                                                            if Blips['NPCTargetTowableZone'] then
                                                                RemoveBlip(Blips['NPCTargetTowableZone'])
                                                                Blips['NPCTargetTowableZone'] = nil
                                                            end

                                                            Blips['NPCDelivery'] = AddBlipForCoord(Config2.Zones.VehicleDelivery.Pos.x, Config2.Zones.VehicleDelivery.Pos.y, Config2.Zones.VehicleDelivery.Pos.z)
                                                            SetBlipRoute(Blips['NPCDelivery'], true)
                                                        end
                                                    end
                                                else
                                                    ESX.ShowNotification('~r~Impossible~s~ d\'attacher votre propre dépanneuse')
                                                end
                                            end
                                        else
                                            ESX.ShowNotification('il n\'y a ~r~pas de véhicule~s~ à attacher')
                                        end
                                    else
                                        AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        DetachEntity(CurrentlyTowedVehicle, true, true)

                                        if NPCOnJob then
                                            if NPCTargetDeleterZone then

                                                if CurrentlyTowedVehicle == NPCTargetTowable then
                                                    ESX.Game.DeleteVehicle(NPCTargetTowable)
                                                    TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
                                                    StopNPCJob()
                                                    NPCTargetDeleterZone = false
                                                else
                                                    ESX.ShowNotification('ce n\'est pas le bon véhicule')
                                                end

                                            else
                                                ESX.ShowNotification('Pas de Place a Droite')
                                            end
                                        end

                                        CurrentlyTowedVehicle = nil
                                        ESX.ShowNotification('vehicule ~b~détattaché~s~ avec succès!')
                                    end
                                else
                                    ESX.ShowNotification('~r~Impossible! ~s~Vous devez avoir un ~b~Flatbed ~s~pour ça')
                                end
                                end
                            end)

                            end, function() 
                            end)
    
                if not RageUI.Visible(fBennysf6) and not RageUI.Visible(fBennysf6Sub) and not RageUI.Visible(fBennysf6Sub1) then
                    fBennysf6 = RMenu:DeleteType("Benny's", true)
        end
    end
end


Keys.Register('F6', 'Bennys', 'Ouvrir le menu Benny\'s', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
        Menuf6Bennys()
    end
end)


RegisterNetEvent('fBennys:Fourriere')
AddEventHandler('fBennys:Fourriere', function(service, nom, message)
    if service == 'Demande' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('Demande dépanneur', '~b~A lire', 'Demande par: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_MINOTAUR', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)    
    end
end)

RegisterNetEvent('fBennys:setBlip')
AddEventHandler('fBennys:setBlip', function(coords)
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Demande dépanneur')
    EndTextCommandSetBlipName(blipId)
    Wait(80 * 1000)
    RemoveBlip(blipId)
end)

RegisterNetEvent('rMecano:MettiCrick')
AddEventHandler('rMecano:MettiCrick', function(ped, coords, veh)
    local dict
    local model = 'prop_carjack'
    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
    local headin = GetEntityHeading(ped)
    local vehicle   = ESX.Game.GetVehicleInDirection()
    FreezeEntityPosition(veh, true)
    local vehpos = GetEntityCoords(veh)
    dict = 'mp_car_bomb'
    RequestAnimDict(dict)
    RequestModel(model)
    while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
    local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
    exports['progressBars']:startUI(9250, "POSITIONNEMENT DU CRIC") -- TRANSLATE THIS, THAT SAY WHEN YOU PUT THE CRIC
    AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
    Citizen.Wait(1250)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    dict = 'move_crawl'
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
    SetEntityCollision(veh, false, false)
    TaskPedSlideToCoord(ped, offset, headin, 1000)
    Citizen.Wait(1000)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    exports['progressBars']:startUI(11000, "RÉGLAGE DU VÉHICULE") -- TRANSLATE THIS - THAT SAY WHEN YOU REPAIR THE VEHICLE
    TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
    dict = 'amb@world_human_vehicle_mechanic@male@base'
    Citizen.Wait(3000)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
    TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
    dict = 'move_crawl'
    Citizen.Wait(5000)
    local coords2 = GetEntityCoords(ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
    TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
    Citizen.Wait(3000)
    dict = 'mp_car_bomb'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    ClearPedTasksImmediately(playerPed)
    exports['progressBars']:startUI(8250, "ENLEVER LE CRICK") -- TLANSTALE THIS - THAT SAY WHEN YOU LEAVE THE CRIC
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
    Citizen.Wait(1250)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    dict = 'move_crawl'
    Citizen.Wait(1000)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
    TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
    SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
    FreezeEntityPosition(veh, false)
    DeleteObject(vehjack)
    SetEntityCollision(veh, true, true)
end)