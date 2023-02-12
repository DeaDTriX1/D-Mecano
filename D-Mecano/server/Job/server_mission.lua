ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Missions

RegisterNetEvent("mecano:EndMission")
AddEventHandler("mecano:EndMission", function(job)
    local name = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "mechanic" then
        TriggerEvent("AC:Violations", 24, "Event: mecano:EndMission job: "..xPlayer.job.name, source)
        return
    end

    local gain = math.random(150,300)
    xPlayer.addMoney(gain)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
        if account ~= nil then
            societyAccount = account
            societyAccount.addMoney(gain * 2)
        end
        sendToDiscordWithSpecialURL("Bennys", "Profit de "..name, gain, 1942002, Config2.webhookDiscordGainMissions)
        sendToDiscordWithSpecialURL("Bennys", "Profit Societée "..name, tostring(gain * 2), 1942002, Config2.webhookDiscordGainsosiety)
    end)

    TriggerClientEvent("esx:showNotification", source, "Vous avez terminé votre mission.\nGain: ~g~"..gain.."~s~€\nGain entreprise: ~g~".. tostring(gain * 2) .."~s~€", "CHAR_LAZLOW", 5000, "danger")
end)