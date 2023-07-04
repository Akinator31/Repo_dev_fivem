RegisterCommand("position", function(source, args)
        
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local plyHeading = GetEntityHeading(plyPed)

    TriggerServerEvent("sv_savePositions:savePosition", plyHeading, plyPos.x, plyPos.y, plyPos.z)

    print("[Obtain Position] Heading: " .. plyHeading .. " | x: " .. plyPos.x .. " | y: " .. plyPos.y .. " | z: " .. plyPos.z)
    TriggerEvent("chatMessage", "^1Serveur: " .. plyHeading .. " | x: " .. plyPos.x .. " | y: " .. plyPos.y .. " | z: " .. plyPos.z)
    
    Citizen.Wait(1)

end, false)