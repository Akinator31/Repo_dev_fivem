-- Création d'une commande permettant de faire spawn un véhicule

RegisterCommand("spawn_car", function(source, args)
    local model = args[1]

    if not IsModelInCdimage(model) or not IsModelAVehicle(model) then
        TriggerEvent("chatMessage", "^1Erreur: ^0Le véhicule n'existe pas")
        return
        else
            TriggerEvent("chatMessage", "^1Serveur: ^0Le modèle existe")
    end

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(500)
    end

    playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- Faire en sorte que le véhicule spawn à côté du joueur

    SetPedIntoVehicle(playerPed, vehicle, -1) -- -1 = driver seat, 0 = front right seat, 1 = back left seat, 2 = back right seat

end , false)

-- Création d'une commande qui supprime un véhicule quand on est à côté

RegisterCommand("delete_car", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    DeleteEntity(vehicle)

    -- Si le joueur est dans un véhicule, on supprime le véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        DeleteEntity(vehicle)
    end

    -- Faire en sorte que le joueur puisse supprimer un vécule alors qu'un pnj est dedans

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local ped = GetPedInVehicleSeat(vehicle, -1)
        DeleteEntity(vehicle)
        DeleteEntity(ped)
    end

end , false)

-- Création d'une commande qui permet de réparer un véhicule

RegisterCommand("repair_car", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    SetVehicleFixed(vehicle)

    -- Si le joueur est dans un véhicule, on répare le véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleFixed(vehicle)
    end

end , false)

-- Création d'une commande qui permet de nettoyer un véhicule

RegisterCommand("clean_car", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    SetVehicleDirtLevel(vehicle, 0)

    -- Si le joueur est dans un véhicule, on nettoie le véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleDirtLevel(vehicle, 0)
    end

end , false)

-- Création d'une commande qui éteint automatique la radio quand on monte quand un véhicule

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            SetVehicleRadioEnabled(vehicle, false)
        end
    end
end)


-- Création d'une commande qui permet de donner une arme au joueur ou de lui enlever

RegisterCommand("give_weapon", function(source, args)
    local playerPed = PlayerPedId()
    local weapon = args[1]

    if not IsPedArmed(playerPed, 4) and IsWeaponValid(GetHashKey(weapon)) then
        GiveWeaponToPed(playerPed, GetHashKey(weapon), 1000, false, false)
        TriggerEvent("chatMessage", "^1Serveur: ^0Vous avez reçu une arme")
    end
end, false)

RegisterCommand("delete_weapon", function(source, args)
    local playerPed = PlayerPedId()
    RemoveAllPedWeapons(playerPed, true)
    TriggerEvent("chatMessage", "^1Serveur: ^0Vous avez perdu vos armes")
    print(IsPedArmed(playerPed, 4))
end)

-- Création d'une commande qui permet de donner l'état d'un véhicule proche du joueur

RegisterCommand("get_state", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    local state = GetVehicleEngineHealth(vehicle)

    TriggerEvent("chatMessage", "^1Serveur: ^0L'état du véhicule est de: " .. state)

    -- Si le joueur est dans un véhicule, on lui donne l'état du véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local state = GetVehicleEngineHealth(vehicle)

        TriggerEvent("chatMessage", "^1Serveur: ^0L'état du véhicule est de: " .. state)
    end

end , false)

-- Création d'une commande qui permet de donner la vitesse d'un véhicule proche du joueur

RegisterCommand("get_speed", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    local speed = GetEntitySpeed(vehicle)

    TriggerEvent("chatMessage", "^1Serveur: ^0La vitesse du véhicule est de: " .. speed)

    -- Si le joueur est dans un véhicule, on lui donne la vitesse du véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local speed = GetEntitySpeed(vehicle)

        TriggerEvent("chatMessage", "^1Serveur: ^0La vitesse du véhicule est de: " .. speed)
    end

end , false)

-- Création d'une commande qui permet de changer la couleur d'un véhicule proche du joueur

RegisterCommand("change_color", function(source, args)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
    local color = args[1]

    SetVehicleColours(vehicle, color, color)

    -- Si le joueur est dans un véhicule, on lui change la couleur du véhicule dans lequel il est

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local color = args[1]

        SetVehicleColours(vehicle, color, color)
    end

end , false)

-- Création d'une commande qui rend le joueur invisible

RegisterCommand("invisible", function(source, args)
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false)

    TriggerEvent("chatMessage", "^1Serveur: ^0Vous êtes invisible")

end , false)

-- Création d'une commande qui rend le joueur visible

RegisterCommand("visible", function(source, args)
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true)

    TriggerEvent("chatMessage", "^1Serveur: ^0Vous êtes visible")

end , false)

-- Création d'une commande qui rend le joueur invincible et qui inverse cette action quand on la réutilise

RegisterCommand("invincible", function(source, args)
    local playerPed = PlayerPedId()
    local god = GetPlayerInvincible(playerPed)

    if god then
        SetPlayerInvincible(playerPed, false)
        TriggerEvent("chatMessage", "^1Serveur: ^0Vous n'êtes plus invincible")
    else
        SetPlayerInvincible(playerPed, true)
        TriggerEvent("chatMessage", "^1Serveur: ^0Vous êtes invincible")
    end

end , false)

-- Création d'une commande qui permet de faire spawn un pnj

RegisterCommand("spawn_ped", function(source, args)
    local model = args[1]

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local ped = CreatePed(4, model, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- Faire en sorte que le pnj spawn à côté du joueur

    SetPedIntoVehicle(playerPed, ped, -1) -- -1 = driver seat, 0 = front right seat, 1 = back left seat, 2 = back right seat

end , false)

-- Création d'une commande qui permet de give de l'argent au joueur

RegisterCommand("give_money", function(source, args)
    local playerPed = PlayerPedId()
    local moneyGived = args[1]

    TriggerServerEvent("giveMoney", moneyGived)

end , false)

