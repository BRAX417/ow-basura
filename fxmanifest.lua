fx_version('cerulean')
games{ 'gta5' }

author 'mano.6195 - gg/ownicm'
description 'Garbage collection system with ox_target'

client_scripts {
    'Client/*.lua'
}

server_scripts {
    'Server/*.lua'
}

shared_scripts {
    'Shared/*.lua',
    '@es_extended/imports.lua',
}

dependencies {
    'ox_target'
}