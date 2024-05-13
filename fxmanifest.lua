version '1.0'
author 'Kpri'
description 'kKevlar'

escrow_ignore {
    
    "shared/*.lua"
}

server_scripts {

    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'

}


client_scripts {

	'client/*.lua'

}


shared_script {

    "shared/*.lua"

}





lua54 'yes'
game 'gta5'
fx_version 'cerulean'