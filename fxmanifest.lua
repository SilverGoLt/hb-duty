fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Boost#4383'
description 'Boost`s rc-duty'
version '1.0.0'

lua54 'yes'

shared_scripts{
    '@rc-core/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts{
    'client.lua'
}

server_scripts{
    'server.lua'
}