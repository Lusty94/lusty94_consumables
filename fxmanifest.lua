fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Lusty94'

description 'Consumables Script For QB-Core'

version '1.0.0'


client_scripts {
    'client/consumables_client.lua',
}

server_scripts {
    'server/consumables_server.lua',
} 

shared_scripts { 
	'shared/config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'shared/**.lua',
    'client/**.lua',
    'server/**.lua',
}




