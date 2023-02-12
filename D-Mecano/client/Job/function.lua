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

ObjectInFront = function(ped, pos)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
    local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
    local _, _, _, _, result = GetRaycastResult(car)
    return result
end

function GetCloseVehi()
    local player = GetPlayerPed(-1)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(2, vCoords.x, vCoords.y, vCoords.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 102, 0, 170, 0, 1, 2, 0, nil, nil, 0)
end

function Coffrebennys()
    local Cbennys = RageUI.CreateMenu("Coffre", "Benny's")
    Cbennys:SetRectangleBanner(150, 0, 0)
        RageUI.Visible(Cbennys, not RageUI.Visible(Cbennys))
            while Cbennys do
            Citizen.Wait(0)
            RageUI.IsVisible(Cbennys, true, true, true, function()

                RageUI.Separator("~y~↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BennysRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BennysDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                RageUI.Separator("~y~↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformebennys()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cbennys) then
            Cbennys = RMenu:DeleteType("Cbennys", true)
        end
    end
end


Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Bennys.pos.coffre.position.x, Bennys.pos.coffre.position.y, Bennys.pos.coffre.position.z)
            if jobdist <= 20.0 and Bennys.jeveuxmarker then
                Timer = 0
                DrawMarker(22, Bennys.pos.coffre.position.x, Bennys.pos.coffre.position.y, Bennys.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrebennys()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageBennys()
  local GBennys = RageUI.CreateMenu("Garage", "Benny's")
  GBennys:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(GBennys, not RageUI.Visible(GBennys))
        while GBennys do
            Citizen.Wait(0)
                RageUI.IsVisible(GBennys, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            end 
                        end
                    end) 

                    for k,v in pairs(GBennysvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarBennys(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GBennys) then
            GBennys = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bennys.pos.garage.position.x, Bennys.pos.garage.position.y, Bennys.pos.garage.position.z)
            if dist3 <= 20.0 and Bennys.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Bennys.pos.garage.position.x, Bennys.pos.garage.position.y, Bennys.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBennys()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

Citizen.CreateThread(function()
        while true do
            local Timer = 5000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bennys.pos.deleteveh.position.x, Bennys.pos.deleteveh.position.y, Bennys.pos.deleteveh.position.z)
            if dist3 <= 5.0 and Bennys.jeveuxmarkerr then
                Timer = 0
                DrawMarker(20, Bennys.pos.deleteveh.position.x, Bennys.pos.deleteveh.position.y, Bennys.pos.deleteveh.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour supprimée ton véhicule", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        DeleteEntity(veh)
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarBennys(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Bennys.pos.spawnvoiture.position.x, Bennys.pos.spawnvoiture.position.y, Bennys.pos.spawnvoiture.position.z, Bennys.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Benny's"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end


itemstock = {}
function BennysRetirerobjet()
    local Stockbennys = RageUI.CreateMenu("Coffre", "Benny's")
    Stockbennys:SetRectangleBanner(150, 0, 0)
    ESX.TriggerServerCallback('fbennys:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockbennys, not RageUI.Visible(Stockbennys))
        while Stockbennys do
            Citizen.Wait(0)
                RageUI.IsVisible(Stockbennys, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fbennys:getStockItem', v.name, tonumber(count))
                                    BennysRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockbennys) then
            Stockbennys = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function BennysDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Benny's")
    StockPlayer:SetRectangleBanner(150, 0, 0)
    ESX.TriggerServerCallback('fbennys:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('fbennys:putStockItems', item.name, tonumber(count))
                                            BennysDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function vuniformebennys()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Bennys.tenue.male
        else
            uniformObject = Bennys.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

function cooldowncool(time)
    cooldown = true
    Citizen.SetTimeout(time,function()
        cooldown = false
    end)
end

local isInMission = false
local veh_mission = {}
local blip = nil

Citizen.CreateThread(function()
        while true do
            local Timer = 5000
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bennys.pos.deleteveh.position.x, Bennys.pos.deleteveh.position.y, Bennys.pos.deleteveh.position.z)
            if dist3 <= 5.0 and Bennys.jeveuxmarkerr then
                Timer = 0
                DrawMarker(20, Bennys.pos.deleteveh.position.x, Bennys.pos.deleteveh.position.y, Bennys.pos.deleteveh.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour supprimée ton véhicule", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        DeleteEntity(veh)
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function GerRandomZone()
    return SpawnVehicule[math.random(1,#SpawnVehicule)]
end

function GerRandomzoneForJob()
    return FourriereFIN[math.random(1,#FourriereFIN)]
end

function GerRandomVeh()
    return RemorqueVeh[math.random(1,#RemorqueVeh)]
end

function GenerateRandomMods(veh)
    SetVehicleModKit(veh, 0)
    for i = 0,49 do
        local num = GetNumVehicleMods(veh, i)
        if num ~= nil and num ~= 0 then
            SetVehicleMod(veh, i, math.random(0,num), true)
        end
    end

    SetVehicleDirtLevel(veh, math.random(1,10) / 100)
    for i = 1,50 do
        SetVehicleDamage(veh, math.random(1, 50) / 100, math.random(1, 50) / 100,math.random(1, 50) / 100, 200.0, 100.0, true)
    end
end

function StopMission()
    RemoveBlip(blip)
    TriggerServerEvent("DeleteEntity", veh_mission)
    veh_mission = {}
    isInMission = false
end

function StartMecanoMission()
    if isInMission then
        isInMission = false
        PlaySoundFrontend(-1, "Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
        TriggerEvent("esx:showNotification", "~r~Vous avez annulé votre mission.", "CHAR_CHAT_CALL", 5000, "danger")
        return
    else
        Citizen.CreateThread(function()
            isInMission = true
            local zone = GerRandomZone()
            local veh = GerRandomVeh()
            local zoneForJob = GerRandomzoneForJob()

            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, zone, true)

            PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
            TriggerEvent("esx:showNotification", "~g~Une mission vous à été attribué! Regarder votre GPS!", "CHAR_CHAT_CALL", 5000, "danger")

            blip = AddBlipForCoord(zone)
            SetBlipScale(blip, 1.2)
            SetBlipRoute(blip, true)

            while dst > 130.0 and isInMission do
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, zone, true)
                Wait(500)
            end

            if not isInMission then StopMission() return end

            local model = GetHashKey(veh)
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(1) end
            local veh = CreateVehicle(GetHashKey(veh), zone, 1, 1)
            SetEntityAsMissionEntity(veh, 1, 1)
            GenerateRandomMods(veh)
            table.insert(veh_mission, NetworkGetNetworkIdFromEntity(veh))

            while not IsEntityAttached(veh) and isInMission do
                Wait(500)
            end

            if not isInMission then StopMission() return end

            SetBlipCoords(blip, zoneForJob)
            SetBlipRoute(blip, true)

            while dst > 5.0 and isInMission do
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, zoneForJob, true)
                Wait(500)
            end

            if not isInMission then StopMission() return end

            while IsEntityAttached(veh) and isInMission do
                Wait(500)
            end

            if not isInMission then StopMission() return end

            ESX.ShowNotification('~g~[F6]~s~ ET METTRE LE VEHICULE EN FOURRIERE')
            TriggerServerEvent("mecano:EndMission", pJob)
            PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
            StopMission()
        end)
    end
end 