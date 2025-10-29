Config = {}

-- List of specific garage IDs that should use the fancy UI
-- Only these garages will have the fancy 3D preview
-- Other garages from _vehicleStorage will use the default list menu
Config.FancyUIGarages = {
    "mba_public_parking",           -- Maze Bank Arena
    "alta_parking",                 -- Alta/Downtown (YOUR VEHICLES ARE HERE)
    "vineyard_public_parking",      -- Vineyard
    "popular_st_parking",           -- Popular Street
    "parsons_parking",              -- Parsons Rehabilitation
    "mirror_park_plaza",            -- Mirror Park Plaza
    "morningwood_blvd",             -- Morningwood Blvd
    "puerta_marina",                -- Puerto del Sol Marina
    "sisyphus",                     -- Sisyphus Theater
    "airport",                      -- LSIA Public Parking
    "paleto_bay",                   -- Paleto Bay
    "chumash",                      -- Chumash
    "route_68",                     -- Route 68
    "harmony",                      -- Harmony
    "san_vitus_parking",            -- San Vitus
    "southside_strawberry_ave",     -- Strawberry Ave
    "casino_parking",               -- Diamond Casino
    "richards_tower_parking",       -- Richards Majestic
    "townhall_public_parking",      -- Town Hall
    "st_fiacre_public",             -- St. Fiacre
    "mount_zonah_public",           -- Mount Zonah
    "vanilla_unicorn_public",       -- Vanilla Unicorn
    "bahama_mama_public",           -- Bahama Mamas
    "autoexotics_public",           -- Auto Exotics Public
    -- Add more garage IDs here that you want to use the fancy UI for
}

-- Camera configurations for fancy UI garages
Config.GarageCameras = {
    ["mba_public_parking"] = {
        vehSpawn = vector4(-203.0, -1940.0, 27.5, 298.0),
        location = { 
            posX = -208.0, 
            posY = -1945.0, 
            posZ = 29.0, 
            rotX = -15.0, 
            rotY = 0.0, 
            rotZ = 30.0, 
            fov = 50.0 
        },
    },
    ["alta_parking"] = {
        vehSpawn = vector4(-470.0, -810.0, 30.5, 0.0),
        location = { 
            posX = -475.0, 
            posY = -815.0, 
            posZ = 32.0, 
            rotX = -15.0, 
            rotY = 0.0, 
            rotZ = 45.0, 
            fov = 50.0 
        },
    },
    ["vineyard_public_parking"] = {
        vehSpawn = vector4(-1900.0, 2034.9, 140.1, 159.0),
        location = { 
            posX = -1905.0, 
            posY = 2030.0, 
            posZ = 142.0, 
            rotX = -15.0, 
            rotY = 0.0, 
            rotZ = 160.0, 
            fov = 50.0 
        },
    },
    -- Add more custom camera configs here as needed
}

-- This will be populated from _vehicleStorage at runtime
Config.Garages = {}
