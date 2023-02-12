fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

	'@es_extended/locale.lua',
    'locales/fr.lua',
	'client/Custom/client_custom.lua',
    'client/Custom/function.lua',
    'shared/Custom/*.lua',
    'client/Job/*.lua',
    'shared/Job/config.lua',
    'shared/Custom/functions.lua',
    'shared/Custom/config.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'locales/fr.lua',
    'server/Custom/server_custom.lua',
    'shared/Custom/*.lua',
    'server/Job/server_job.lua',
    'shared/Job/config.lua',
    'shared/Custom/functions.lua',
    'shared/Custom/config.lua',
    'server/Job/server_mission.lua',
}