-- Sandbox Framework Garage System
local LastCamera, currentVeh, vehCam = nil, nil, nil
local LastSpawnPos = nil
local LastStorageId = nil
local currentGarageData = nil
local lastInteractionTime = 0
local lastSoundTime = 0
local vehicleParkingSpaces = {} -- Maps VIN to parking space vector4
local savedParkingSpaces = {} -- Persistent storage: VIN -> {space = vector4, garageId = string}
local isVisible = false -- Track if garage UI is open

-- Thread to hide HUD elements while garage UI is open
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if isVisible then
            HideHudComponentThisFrame(1)  -- Wanted Stars
            HideHudComponentThisFrame(2)  -- Weapon Icon
            HideHudComponentThisFrame(3)  -- Cash
            HideHudComponentThisFrame(4)  -- MP Cash
            HideHudComponentThisFrame(6)  -- Vehicle Name
            HideHudComponentThisFrame(7)  -- Area Name
            HideHudComponentThisFrame(8)  -- Vehicle Class
            HideHudComponentThisFrame(9)  -- Street Name
            HideHudComponentThisFrame(13) -- Cash Change
            HideHudComponentThisFrame(19) -- Weapon Wheel
        else
            Wait(500) -- Sleep when UI is not visible
        end
    end
end)

-- Load parking spaces from server
function LoadParkingSpaces()
    exports['sandbox-base']:ServerCallback('Garage:LoadParkingSpaces', {}, function(data)
        if data then
            -- Convert serialized data back to vector4
            for vin, spaceData in pairs(data) do
                if spaceData.space then
                    savedParkingSpaces[vin] = {
                        space = vector4(spaceData.space.x, spaceData.space.y, spaceData.space.z, spaceData.space.w),
                        garageId = spaceData.garageId
                    }
                end
            end
            print("^2[ES-GARAGE] Loaded " .. TableLength(savedParkingSpaces) .. " saved parking spaces^7")
        end
    end)
end

function SaveParkingSpace(vin, space, garageId)
    -- Convert vector4 to serializable format
    local serializable = {
        space = {
            x = space.x,
            y = space.y,
            z = space.z,
            w = space.w
        },
        garageId = garageId
    }
    
    -- Send to server to save
    TriggerServerEvent('Garage:SaveParkingSpace', vin, serializable)
end

function TableLength(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- Helper Functions
function GetGarageAtCoords(coords)
    local insideZone = exports['sandbox-polyzone']:IsCoordsInZone(coords, false, 'es_garage')
    if insideZone and insideZone.es_garage and insideZone.es_garage_id then
        return true, insideZone.es_garage_id
    end
    return false
end

function IsParkingSpaceFree(coords)
    local vehicles = GetGamePool('CVehicle')
    for _, vehicle in ipairs(vehicles) do
        if DoesEntityExist(vehicle) then
            local vehCoords = GetEntityCoords(vehicle)
            if #(vehCoords - coords.xyz) < 3.0 then
                return false
            end
        end
    end
    return true
end

function GetClosestAvailableParkingSpace(pedCoords, spaces)
    local closestSpace = nil
    local closestDist = 999999.0
    
    for _, space in ipairs(spaces) do
        if IsParkingSpaceFree(space) then
            local dist = #(pedCoords - space.xyz)
            if dist < closestDist then
                closestDist = dist
                closestSpace = space
            end
        end
    end
    
    return closestSpace
end

function GetClosestParkingSpace(pedCoords, spaces)
    local closestSpace = nil
    local closestDist = 999999.0
    
    for _, space in ipairs(spaces) do
        local dist = #(pedCoords - space.xyz)
        if dist < closestDist then
            closestDist = dist
            closestSpace = space
        end
    end
    
    return closestSpace
end

-- Initialize - Load garages from _vehicleStorage and add camera configs
Citizen.CreateThread(function()
    -- Wait for player to be ready
    while not LocalPlayer.state.loggedIn do
        Wait(1000)
    end
    
    Wait(2000) -- Extra wait for sandbox-vehicles to fully load
    
    -- Load saved parking spaces from file
    LoadParkingSpaces()
    
    -- Load garage data from sandbox-vehicles
    if _vehicleStorage then
        for storageId, storageData in pairs(_vehicleStorage) do
            -- Check if this garage should use fancy UI
            local useFancyUI = false
            for _, fancyId in ipairs(Config.FancyUIGarages) do
                if fancyId == storageId then
                    useFancyUI = true
                    break
                end
            end
            
            if useFancyUI then
                -- Get or generate camera config
                local cameraConfig = Config.GarageCameras[storageId]
                if not cameraConfig and storageData.spaces and storageData.spaces[1] then
                    -- Auto-generate camera position based on first spawn point
                    local spawn = storageData.spaces[1]
                    local heading = spawn.w or 0.0
                    
                    -- Place camera 5 units behind and 2 units up from spawn point
                    local radians = math.rad(heading + 180)
                    local offsetX = math.sin(radians) * 5.0
                    local offsetY = math.cos(radians) * 5.0
                    
                    cameraConfig = {
                        vehSpawn = spawn,
                        location = {
                            posX = spawn.x + offsetX,
                            posY = spawn.y + offsetY,
                            posZ = spawn.z + 2.0,
                            rotX = -15.0,
                            rotY = 0.0,
                            rotZ = heading,
                            fov = 50.0
                        }
                    }
                end
                
                -- Merge sandbox-vehicles data with our camera config
                Config.Garages[storageId] = {
                    name = storageData.name,
                    coords = storageData.coords,
                    vehType = storageData.vehType,
                    Type = storageData.vehType == 0 and 'car' or (storageData.vehType == 2 and 'air' or 'sea'),
                    UIName = storageData.name,
                    zone = storageData.zone,
                    spaces = storageData.spaces,
                    Camera = cameraConfig or {
                        vehSpawn = vector4(0, 0, 0, 0),
                        location = { 
                            posX = 0, posY = 0, posZ = 10, 
                            rotX = -15, rotY = 0, rotZ = 0, 
                            fov = 50 
                        }
                    },
                    restricted = storageData.restricted,
                    default = storageData.default,
                    hideBlip = storageData.hideBlip,
                }
                
                -- Create PolyZone (sandbox-vehicles already creates them, but we need our own data tag)
                if storageData.zone then
                    local data = {
                        es_garage = true,
                        es_garage_id = storageId,
                    }
                    
                    if storageData.zone.type == 'box' then
                        exports['sandbox-polyzone']:CreateBox('es_garage_' .. storageId, storageData.zone.center, storageData.zone.length, storageData.zone.width, {
                            heading = storageData.zone.heading or 0,
                            minZ = storageData.zone.minZ,
                            maxZ = storageData.zone.maxZ,
                            debugPoly = false
                        }, data)
                    elseif storageData.zone.type == 'poly' and storageData.zone.points then
                        exports['sandbox-polyzone']:CreatePoly('es_garage_' .. storageId, storageData.zone.points, {
                            minZ = storageData.zone.minZ,
                            maxZ = storageData.zone.maxZ,
                            debugPoly = false
                        }, data)
                    end
                end
            end
        end
        
        -- Wait for zones to be fully created before registering interaction
        Wait(1000)
        
                -- Register our interaction menu AFTER zones are ready
                exports['sandbox-hud']:InteractionRegisterMenu("veh_storage", "Open Garage", "warehouse", function()
                    -- Cooldown to prevent multiple clicks
                    local currentTime = GetGameTimer()
                    if currentTime - lastInteractionTime < 2000 then
                        return
                    end
                    lastInteractionTime = currentTime
            
            local pedCoords = GetEntityCoords(PlayerPedId())
            local inGarage, garageId = GetGarageAtCoords(pedCoords)
            if inGarage then
                OpenGarageUI()
            end
            exports['sandbox-hud']:InteractionHide()
        end, function()
            local pedCoords = GetEntityCoords(PlayerPedId())
            local inGarage, garageId = GetGarageAtCoords(pedCoords)
            return inGarage
        end)
    else
        print("^1[ES-GARAGE] ERROR: _vehicleStorage table not found! Make sure sandbox-vehicles is loaded.^7")
    end
end)

-- Hook into vehicle storage to remember parking space
AddEventHandler('Vehicles:Client:StoreVehicle', function(entityData)
    if entityData and DoesEntityExist(entityData.entity) then
        local vehState = Entity(entityData.entity).state
        if vehState and vehState.VIN then
            local vehicleCoords = GetEntityCoords(entityData.entity)
            local inGarage, garageId = GetGarageAtCoords(vehicleCoords)
            
            if inGarage and Config.Garages[garageId] and Config.Garages[garageId].spaces then
                -- Find closest parking space
                local closestSpace = nil
                local closestDist = 999999
                
                for _, space in ipairs(Config.Garages[garageId].spaces) do
                    local dist = #(vehicleCoords - space.xyz)
                    if dist < closestDist then
                        closestDist = dist
                        closestSpace = space
                    end
                end
                
                if closestSpace then
                    -- Save this parking space for this VIN
                    savedParkingSpaces[vehState.VIN] = {
                        space = closestSpace,
                        garageId = garageId
                    }
                    
                    -- Save to file for persistence (via server)
                    SaveParkingSpace(vehState.VIN, closestSpace, garageId)
                end
            end
        end
    end
end)

function OpenGarageUI()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local inGarage, garageId = GetGarageAtCoords(pedCoords)
    
    if not inGarage or not garageId then
        return
    end
    
    local garageData = Config.Garages[garageId]
    if not garageData then
        return
    end
    
    currentGarageData = garageData
    
    -- Find parking space
    local parkingSpace = nil
    if garageData.spaces then
        if garageData.vehType == 0 then
            parkingSpace = GetClosestParkingSpace(pedCoords, garageData.spaces)
        else
            parkingSpace = GetClosestAvailableParkingSpace(pedCoords, garageData.spaces)
        end
    end
    
    if not parkingSpace then
        exports['sandbox-hud']:Notification("error", "Could Not Find Parking Space")
        return
    end
    
    LastSpawnPos = parkingSpace
    
    -- Get vehicles from server
    exports['sandbox-base']:ServerCallback('Garage:GetVehicles', garageId, function(response)
        if response and response.vehicles then
            ProcessVehicles(response.vehicles, garageData, garageId, response.stats)
        else
            exports['sandbox-hud']:Notification("error", "Failed to load vehicle data")
        end
    end)
end

function ProcessVehicles(vehicles, text, storageId, stats)
    if vehicles and #vehicles > 0 then 
        local data = {}
        vehicleParkingSpaces = {} -- Reset parking space assignments
        
        -- Use ALL parking spaces for consistent VIN hash assignment
        local allSpaces = text.spaces or {}
        
        for k, v in pairs(vehicles) do
            local class = GetVehicleClassFromName(v.Model)
            
            -- First, check if we have a saved parking space for this vehicle
            if savedParkingSpaces[v.VIN] and savedParkingSpaces[v.VIN].garageId == storageId then
                -- Use the saved parking space where they actually parked it
                vehicleParkingSpaces[v.VIN] = savedParkingSpaces[v.VIN].space
            elseif #allSpaces > 0 then
                -- Fallback: Use VIN hash to deterministically assign a parking space
                local vinHash = 0
                for i = 1, #v.VIN do
                    vinHash = vinHash + string.byte(v.VIN, i)
                end
                local spaceIndex = (vinHash % #allSpaces) + 1
                vehicleParkingSpaces[v.VIN] = allSpaces[spaceIndex]
            else
                -- Last resort: Use camera spawn point
                vehicleParkingSpaces[v.VIN] = text.Camera.vehSpawn
            end
            
            -- Convert vehicle data to UI format
            local vehicleData = {
                VIN = v.VIN,
                vehicle = v.Model, 
                model = GetDisplayNameFromVehicleModel(v.Model),
                title = GetLabelText(GetDisplayNameFromVehicleModel(v.Model)),
                mods = v.Properties or {},
                location = text.UIName,
                fuel = 100, -- Default fuel
                plate = v.RegisteredPlate or "UNKNOWN"
            }
            
            -- Categorize vehicle based on garage type
            CategorizeVehicle(vehicleData, text.Type, class, data)
        end
        
        if next(data) ~= nil then
            LastCamera = text.Camera
            LastStorageId = storageId
            
            -- Setup camera and environment BEFORE opening UI
            -- Point camera at the first vehicle's actual parking space
            local firstVehicleSpace = nil
            if data[1] and data[1].VIN and vehicleParkingSpaces[data[1].VIN] then
                local space = vehicleParkingSpaces[data[1].VIN]
                firstVehicleSpace = vector3(space.x, space.y, space.z)
            end
            
            if firstVehicleSpace then
                Camera(firstVehicleSpace)
            else
            Camera()
            end
            SetClockTime(21, 0, 0)  
            SetWeatherTypePersist("EXTRASUNNY")  
            SetWeatherTypeNowPersist("EXTRASUNNY")
            NetworkOverrideClockTime(21, 0, 0) 
            DisplayRadar(false)
            
            -- Hide Sandbox HUD
            exports['sandbox-hud']:Hide()
            
            SetNuiFocus(true, true)
            isVisible = true
            
            -- Small delay to ensure everything is set up before UI opens
            Wait(100)
            
            SendNUIMessage({
                data = "GARAGE",
                car = data,
                name = text.UIName,
                stats = stats or { total = #data, onStreet = 0 }
            })
        else
            exports['sandbox-hud']:Notification("error", "No vehicles available in this garage.")
        end
    else
        exports['sandbox-hud']:Notification("info", "This garage is empty. Store a vehicle here first!")
    end
end

function Camera(targetPos)
    if vehCam then
        DestroyCam(vehCam, false)
    end
    
    -- If we have a target position (vehicle parking space), adjust camera to point at it
    local camPos = vector3(LastCamera.location.posX, LastCamera.location.posY, LastCamera.location.posZ)
    
    if targetPos then
        -- Calculate direction from camera to target
        local direction = vector3(targetPos.x - camPos.x, targetPos.y - camPos.y, targetPos.z - camPos.z)
        local distance = #direction
        
        -- Calculate rotation to look at target
        local rotZ = math.deg(math.atan2(direction.y, direction.x)) - 90.0
        local rotX = math.deg(math.asin(direction.z / distance))
        
        vehCam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', camPos.x, camPos.y, camPos.z, rotX, 0.0, rotZ, LastCamera.location.fov, false, 2)
    else
        -- Use default camera angles
    vehCam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', LastCamera.location.posX, LastCamera.location.posY, LastCamera.location.posZ, LastCamera.location.rotX, LastCamera.location.rotY, LastCamera.location.rotZ, LastCamera.location.fov, false, 2)
    end
    
    SetCamActive(vehCam, true)
    RenderScriptCams(true, true, 2000, true, false, false)
    SetFocusPosAndVel(camPos.x, camPos.y, camPos.z, 0.0, 0.0, 0.0)
    DoScreenFadeIn(1000)
    -- Removed sound - interaction menu already plays its own sound
end

function CategorizeVehicle(vehicle, type, class, data)
    if type == 'car' and class ~= 14 and class ~= 15 and class ~= 16 then
        table.insert(data, vehicle)
    elseif type == 'air' and (class == 15 or class == 16) then
        table.insert(data, vehicle)
    elseif type == 'sea' and class == 14 then
        table.insert(data, vehicle)
    end
end

local cameraZoomLevel = 1.0
local minZoomLevel = 0.5
local maxZoomLevel = 3.0

RegisterNUICallback("rotateright", function()
    if currentVeh then
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) - 2)
    end
end)

RegisterNUICallback("rotateleft", function()
    if currentVeh then
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) + 2)
    end
end)

RegisterNUICallback("zoomIn", function()
    if cameraZoomLevel > minZoomLevel then
        cameraZoomLevel = cameraZoomLevel - 0.1
        SetCamFov(vehCam, 50 / cameraZoomLevel)
    end
end)

RegisterNUICallback("zoomOut", function()
    if cameraZoomLevel < maxZoomLevel then
        cameraZoomLevel = cameraZoomLevel + 0.1
        SetCamFov(vehCam, 50 / cameraZoomLevel)
    end
end)

RegisterNUICallback('VehicleInfo', function(data, cb)
    if not data or not data.data or not data.data.VIN then
        cb({
            Fuel = 0,
            Speed = 0,
            Traction = 0,
            Acceleration = 0
        })
        return
    end
    
    if not LastCamera or not LastCamera.vehSpawn then
        cb({
            Fuel = 0,
            Speed = 0,
            Traction = 0,
            Acceleration = 0
        })
        return
    end

    local model = GetHashKey(data.data.vehicle)
    RequestModel(model)
    
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 100 do
        Wait(50)
        timeout = timeout + 1
    end
    
    if not HasModelLoaded(model) then
        cb({
            Fuel = 0,
            Speed = 0,
            Traction = 0,
            Acceleration = 0
        })
        return
    end
    
    if currentVeh then
        DeleteVehicle(currentVeh)
    end
    
    -- Use the assigned parking space for this vehicle instead of generic spawn point
    local spawnPos = vehicleParkingSpaces[data.data.VIN] or LastCamera.vehSpawn
    
    -- Clear any existing vehicles at this parking spot to prevent collisions
    local nearbyVehicles = GetGamePool('CVehicle')
    for _, veh in ipairs(nearbyVehicles) do
        if DoesEntityExist(veh) then
            local vehCoords = GetEntityCoords(veh)
            local distance = #(vector3(spawnPos.x, spawnPos.y, spawnPos.z) - vehCoords)
            -- If there's a vehicle within 3 meters of the spawn spot, delete it
            if distance < 3.0 then
                DeleteVehicle(veh)
            end
        end
    end
    
    currentVeh = CreateVehicle(model, spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.w, false, true)
    SetVehicleEngineOn(currentVeh, true, true, false)
    
    -- Note: Properties are not applied to preview vehicle (only when actually spawned)
    -- The preview shows the base model, actual vehicle will have all mods when spawned
    
    -- Point camera at the parking space where the vehicle is
    Camera(vector3(spawnPos.x, spawnPos.y, spawnPos.z))
    PointCamAtEntity(vehCam, currentVeh)
    RenderScriptCams(true, false, 0, true, true)
    
    local fuel = 100 -- Default value
    local speed = GetVehicleEstimatedMaxSpeed(currentVeh)
    local traction = GetVehicleMaxTraction(currentVeh)
    local acceleration = GetVehicleAcceleration(currentVeh)
    
    cb({
        Fuel = fuel,
        Speed = speed,
        Traction = traction,
        Acceleration = acceleration
    })
end)

RegisterNUICallback('SpawnVehicle', function(data)
    if not data or not data.VIN then
        exports['sandbox-hud']:Notification("error", "Invalid vehicle data")
        CloseGarage()
        return
    end
    
    -- Use the parking space assigned to this vehicle
    local spawnPos = vehicleParkingSpaces[data.VIN] or LastSpawnPos
    
    if not spawnPos then
        exports['sandbox-hud']:Notification("error", "No parking space available")
        CloseGarage()
        return
    end

    DoScreenFadeOut(500)
    Wait(500)
    
    exports['sandbox-base']:ServerCallback('Garage:SpawnVehicle', {
        VIN = data.VIN,
        coords = spawnPos,
        heading = spawnPos.w,
        storageId = LastStorageId
    }, function(success)
        if success then
            exports['sandbox-hud']:Notification("success", "Vehicle retrieved successfully")
        else
            exports['sandbox-hud']:Notification("error", "Failed to retrieve vehicle")
        end
        
        CloseGarage()
        DoScreenFadeIn(1000)
    end)
end)

function CloseGarage()
    if currentVeh ~= nil then 
        DeleteVehicle(currentVeh)
    end
    
    -- Don't clear LastCamera/LastSpawnPos/LastStorageId - they're reused on next open
    currentVeh = nil
    currentGarageData = nil
    DestroyAllCams(true)
    RenderScriptCams(false, true, 1700, true, false, false)
    SetFocusEntity(GetPlayerPed(PlayerId()))
    SetNuiFocus(false, false)
    DisplayRadar(true)
    isVisible = false
    
    -- Restore Sandbox HUD
    exports['sandbox-hud']:Show()
    
    SendNUIMessage({data = "CLOSE"})
end

RegisterNUICallback("exit", function(data)
    CloseGarage()
end)
