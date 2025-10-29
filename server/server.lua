-- Sandbox Framework Garage System Server

local parkingSpacesFile = "parking_spaces.json"

-- Load parking spaces from file
function LoadParkingSpacesFromFile()
    local data = LoadResourceFile(GetCurrentResourceName(), parkingSpacesFile)
    if data then
        local success, decoded = pcall(json.decode, data)
        if success and decoded then
            return decoded
        end
    end
    return {}
end

-- Save parking spaces to file
function SaveParkingSpacesToFile(spaces)
    local encoded = json.encode(spaces, {indent = true})
    SaveResourceFile(GetCurrentResourceName(), parkingSpacesFile, encoded, -1)
end

-- Initialize garages from _vehicleStorage
Citizen.CreateThread(function()
    Wait(1000) -- Wait for resources to load
    
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
                -- Add to Config.Garages for server-side access
                Config.Garages[storageId] = {
                    name = storageData.name,
                    vehType = storageData.vehType,
                    Type = storageData.vehType == 0 and 'car' or (storageData.vehType == 2 and 'air' or 'sea'),
                }
            end
        end
    end
end)

-- Get vehicles for a specific garage
exports['sandbox-base']:RegisterServerCallback('Garage:GetVehicles', function(source, storageId, cb)
    local character = exports['sandbox-characters']:FetchCharacterSource(source)
    if not character then
        cb(false)
        return
    end

    local garageData = Config.Garages[storageId]
    if not garageData then
        cb(false)
        return
    end

    local characterId = character:GetData('SID')
    local vehType = garageData.Type == 'car' and 0 or (garageData.Type == 'air' and 2 or 1)
    
    -- Get vehicles stored in this garage
    exports['sandbox-vehicles']:OwnedGetAll(vehType, 0, characterId, function(vehicles)
        if vehicles then
            local filteredVehicles = {}
            
            for k, v in ipairs(vehicles) do
                -- Check if vehicle is currently spawned/active
                local isActive = exports['sandbox-vehicles']:OwnedGetActive(v.VIN)
                
                -- Only show vehicles that are stored in THIS garage AND not currently spawned
                if v.Storage and v.Storage.Id == storageId and not isActive and v.Storage.Type == 1 then
                    table.insert(filteredVehicles, v)
                end
            end
            
            cb({ vehicles = filteredVehicles })
        else
            cb({ vehicles = {} })
        end
    end, nil, nil, false, false, {
        _id = 0,
        VIN = 1,
        Make = 1,
        Model = 1,
        Type = 1,
        Owner = 1,
        RegisteredPlate = 1,
        Properties = 1,
        Storage = 1,
    })
end)

-- Spawn vehicle from garage
exports['sandbox-base']:RegisterServerCallback('Garage:SpawnVehicle', function(source, data, cb)
    local character = exports['sandbox-characters']:FetchCharacterSource(source)
    if not character or not data or not data.VIN or not data.coords or not data.heading then
        cb(false)
        return
    end

    local characterId = character:GetData('SID')

    -- Check if vehicle is already spawned
    if exports['sandbox-vehicles']:OwnedGetActive(data.VIN) then
        exports['sandbox-hud']:Notification(source, "error", "Vehicle is already out")
        cb(false)
        return
    end

    -- Get vehicle data
    exports['sandbox-vehicles']:OwnedGetVIN(data.VIN, function(vehicle)
        if vehicle and vehicle.VIN then
            -- Check ownership
            local isAuthedForVehicle = false
            if vehicle.Owner.Type == 0 and tostring(vehicle.Owner.Id) == tostring(characterId) then
                isAuthedForVehicle = true
            end

            if isAuthedForVehicle then
                -- Spawn the vehicle
                exports['sandbox-vehicles']:OwnedSpawn(source, vehicle.VIN, data.coords, data.heading, function(success, vehicleData, vehicleId)
                    if success then
                        -- Give player keys
                        exports['sandbox-vehicles']:KeysAdd(source, vehicle.VIN)
                        cb(true)
                    else
                        cb(false)
                    end
                end)
            else
                exports['sandbox-hud']:Notification(source, "error", "You don't own this vehicle")
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

-- Store vehicle callback removed - sandbox-vehicles handles this automatically

-- Load parking spaces callback
exports['sandbox-base']:RegisterServerCallback('Garage:LoadParkingSpaces', function(source, data, cb)
    local spaces = LoadParkingSpacesFromFile()
    cb(spaces)
end)

-- Save parking space event
RegisterNetEvent('Garage:SaveParkingSpace', function(vin, spaceData)
    if not vin or not spaceData then return end
    
    -- Load existing spaces
    local spaces = LoadParkingSpacesFromFile()
    
    -- Update/add this vehicle's space
    spaces[vin] = spaceData
    
    -- Save back to file
    SaveParkingSpacesToFile(spaces)
end)
