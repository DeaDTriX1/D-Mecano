ESX = nil
local Jobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'mechanic', 'Alerte mechanic', true, true)

TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'public'})

ESX.RegisterServerCallback('fbennys:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('fbennys:getStockItem')
AddEventHandler('fbennys:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', 'Vous avez retiré ~r~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

ESX.RegisterServerCallback('fbennys:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fbennys:putStockItems')
AddEventHandler('fbennys:putStockItems', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', 'Vous avez déposé ~g~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

RegisterServerEvent('fBennys:Ouvert')
AddEventHandler('fBennys:Ouvert', function()
	local name = GetPlayerName(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Norauto', '~y~Informations', 'Norauto est désormais ouvert!', 'CHAR_BENNYS', 2)
	end
	sendToDiscordWithSpecialURL("Bennys", "Annonce de  "..name, 'Le Bennys est actuellement OUVERT !', 1942002, Config2.webhookDiscordfermer)
end)

RegisterServerEvent('fBennys:Fermer')
AddEventHandler('fBennys:Fermer', function()
	local name = GetPlayerName(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Norauto', '~y~Informations', 'Norauto est fermé!', 'CHAR_BENNYS', 2)
	end
	sendToDiscordWithSpecialURL("Bennys", "Annonce de  "..name, 'Le Bennys est actuellement FERMER !', 1942002, Config2.webhookDiscordfermer)
end)

RegisterServerEvent('fBennys:Perso')
AddEventHandler('fBennys:Perso', function(msg)
	local name = GetPlayerName(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Norauto', '~y~Annonce', msg, 'CHAR_BENNYS', 2)
    end
    sendToDiscordWithSpecialURL("Bennys", "Annonce de  "..name,  msg, 1942002, Config2.webhookDiscordperso)
end)

RegisterServerEvent('fBennys:Fourriere')
AddEventHandler('fBennys:Fourriere', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'fourriere' then
            TriggerClientEvent('fBennys:Fourriere', xPlayers[i], _raison, name, message)
        end
		TriggerClientEvent('esx:showNotification', source, "Demande de dépanneur envoyer avec succès!")
    end
end)

RegisterServerEvent('fBennys:renfort')
AddEventHandler('fBennys:renfort', function(coords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'fourriere' then
            TriggerClientEvent('fBennys:setBlip', xPlayers[i], coords)
        end
    end
end)

RegisterServerEvent("D-Mecano:Facture")
AddEventHandler("D-Mecano:Facture", function(name,montant)
	local name = GetPlayerName(source)
	sendToDiscordWithSpecialURL("Bennys", "Facture de " ..name, montant, 1942002, Config2.webhookDiscordfacture)
end)

RegisterServerEvent("D-Mecano:Prise")
AddEventHandler("D-Mecano:Prise", function(name,msg)
	local name = GetPlayerName(source)
	sendToDiscordWithSpecialURL("Bennys", "Début d'une missions de "..name,  msg, 1942002, Config2.webhookDiscordprise)
end)

RegisterServerEvent("D-Mecano:Fin")
AddEventHandler("D-Mecano:Fin", function(name,msg)
	local name = GetPlayerName(source)
	sendToDiscordWithSpecialURL("Bennys", "Fin d'un mission pour "..name,  msg, 1942002, Config2.webhookDiscordprise)
end)


function sendToDiscordWithSpecialURL(name,message,des,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			['description']=des,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = name, avatar_url = "https://help.twitter.com/content/dam/help-twitter/brand/logo.png", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end