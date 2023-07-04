Citizen.CreateThread(function ()

    local model = "trash"
    local pos = {x = -588.21, y = -1591.93, z = 26.75}
    RequestModel(model)
    CreateVehicle(model, pos.x, pos.y, pos.z, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    
end)