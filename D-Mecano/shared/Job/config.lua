Bennys             = {}



Config2                            = {
webhookDiscordfacture = '', -- Facture au joueur
webhookDiscordperso = '', -- Annonce personalisée
webhookDiscordouvert = '', -- Annonce D'ouverture
webhookDiscordfermer = '', -- Annonce de Fermeture
webhookDiscordprise = '', -- Debut et fin d'une missions
webhookDiscordGainMissions = '', -- gain du joueur lors des mission
webhookDiscordGainsosiety = '', -- gain de l'entreprise sur les missions
}






Bennys.jeveuxmarker = true --- true = Oui | false = Non

Bennys.jeveuxblips = true --- true = Oui | false = Non

Bennys.pos = {
	coffre = {
		position = {x = -336.03, y = -158.65, z = 44.58}
	},
	garage = {
		position = {x = -343.55, y = -165.13, z = 39.01}
	},
	spawnvoiture = {
		position = {x = -357.75, y = -157.98, z = 38.72, h = 29.84}
	},
	deleteveh = {
		position = {x = 399.77, y = -1633.26, z = 29.29}
	},
	boss = {
		position = {x = -339.96, y = -157.33, z = 44.58}
	},
	blips = {
		position = {x = -205.57, y = -1308.87, z = 31.29}
	},
}
GBennysvoiture = {
    {nom = "Flat Bed", modele = "flatbed"},
}

Bennys.tenue = {
		male = {
			['tshirt_1'] = 97,  ['tshirt_2'] = 0,
			['torso_1'] = 92,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 154,
			['pants_1'] = 50,   ['pants_2'] = 0,
			['shoes_1'] = 18,   ['shoes_2'] = 6,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['ears_1'] = 15,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
	}
}

marker              = {}

marker.DrawDistance = 10
marker.Size         = {x = 1.5, y = 1.5, z = 1.5}
marker.Color        = {r = 0, g = 255, b = 0}
marker.Type         = 36


marker.zone = {
{x = 400.97 , y = -1631.74, z = 29.29},
}

 SpawnVehicule = { -- ENDROIT OU SPAWN LES VEHICULE
    vector4(491.89169311523, -845.50604248047, 24.980794906616, 39.033138275146),
    vector4(513.06481933594, -637.29772949219, 24.74239730835, 38.930896759033),
    vector4(149.83453369141, -714.80883789062, 33.055198669434, 38.471733093262),
    vector4(257.74771118164, -377.36575317383, 44.566967010498, 129.87409973145),
    vector4(-168.8092956543, -407.89593505859, 34.11901473999, 275.58102416992),
    vector4(-580.96728515625, -656.76361083984, 33.009841918945, 153.74195861816),
    vector4(-1082.517578125, -1244.4296875, 5.1372656822205, 149.92752075195),
    vector4(-848.04577636719, -1724.7478027344, 19.595062255859, 149.49687194824),
    vector4(-598.51202392578, -2359.5065917969, 13.826570510864, 156.93809509277),
}

 RemorqueVeh = { -- VEHICULE QUI SE FONT REMORQUEE
    "blista",
    "brioso",
    "prairie",
    "exemplar",
    "f620",
    "felon",
    "blade",
    "buccaneer",
    "chino2",
    "dominator",
    "dominator3",
    "hotknife",
    "baller3",
    "contender",
    "entityxf",
    "fmj",
}

 FourriereFIN = { -- SPAWN DES FOURRIERE OU RAMENER LE VEHICULE
     vector4(400.97, -1631.74, 29.29, 156.00),
}