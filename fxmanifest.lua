fx_version "cerulean"

description "ES Garage - Modern Garage System with Advanced UI for Sandbox Framework"
author "ES Garage Team | Adapted for Sandbox Framework"
version '3.0.0'

game "gta5"

shared_scripts {
    "@sandbox-vehicles/shared/vehicleStorage.lua",
    "config.lua"
}

client_script { 
    "client/*.lua"
}

server_script {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}

ui_page "ui/dist/index.html"

files {
    'ui/dist/**/*',
    'ui/assets/**/*.png',
}

lua54 'yes'

dependencies {
    'sandbox-base',
    'sandbox-vehicles',
    'sandbox-characters',
    'sandbox-hud',
    'sandbox-polyzone',
    'oxmysql'
}
