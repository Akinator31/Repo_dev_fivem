-- Création de la fonction gérant les notifications

function showAdvancedNotification(message, sender, subject, textureDict, iconType, SaveToBrief, color)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(message)
    ThefeedSetNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, SaveToBrief)
end

-- Création du marker poru accéder au métier eboueur

Citizen.CreateThread(function ()

    local hash = GetHashKey("g_m_y_famdnf_01")
    
    playerPed = PlayerPedId()
        
        while HasModelLoaded(hash) == false do
            RequestModel(hash)
            Wait(20)
        end
        ped = CreatePed("PED_TYPE_CIVMALE", "g_m_y_famdnf_01", -609.9, -1608.8, 26.001, 0, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        while true do
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local dest = vector3(-609.9, -1608.8, 26.001)
            local distance = GetDistanceBetweenCoords(pos, dest, true)

            if distance > 30 then
                interval = 200
            else
                interval = 1

                if distance < 2 then
                    interval = 1
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour accéder au métier d'eboueur")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1, 51) then
                        
                        local model = GetHashKey("Trash")
                        vehicle_job = CreateVehicle(model, -622.6, -1595.4, 26.75, 140.0, GetEntityHeading(90), true, false)
                        SetPedIntoVehicle(playerPed, vehicle_job, -1)

                        TriggerServerEvent("RegisterJobForPlayer")
                        TriggerServerEvent("startJob")

                        showAdvancedNotification("Vous avez reçu votre camion. Ramenez-le en bon état à la fin de votre service !!!", "Dispatcher", "Métier d'eboueur", "CHAR_ARTHUR", 8, true, 130)
                    end
                end
            end
            Citizen.Wait(interval)
        end

    end)

Citizen.CreateThread(function ()

    while true do
        local spawnPed = True
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-610.7, -1594.5, 26.75)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1

            DrawMarker(23, -610.7, -1594.5, 26.00001, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 0, 0, 100, 0, 0, 0, 0)
            if distance < 2 then
                interval = 1
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    DeleteEntity(vehicle_job)
                    showAdvancedNotification("Vous avez rangé votre camion. Allez voir le patron pour recevoir votre paie.", "Dispatcher", "Métier d'eboueur", "CHAR_ARTHUR", 8, true, 130)

                    TriggerServerEvent("finishJob")

                    end
                end
            end

            Citizen.Wait(interval)
        end
end)

Citizen.CreateThread(function ()
    
    -- Création du ped "boss" qui distibuera les paie à la fin de la mission du joueur

    local hashPedBoss = GetHashKey("s_m_m_dockwork_01")
    while HasModelLoaded(hashPedBoss) == false do
        RequestModel(hashPedBoss)
        Wait(20)
    end
    ped2 = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", -636.81, -1634.02, 24.1, 0, false, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
    SetEntityInvincible(ped2, true)
    SetEntityHeading(ped2, 90)
    SetPedDesiredHeading(ped2, 90)
    FreezeEntityPosition(ped2, true)

    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-636.81, -1634.02, 24.1)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        Citizen.Wait(interval)

        if distance > 30 then
            interval = 200
        else
            interval = 1

            if distance < 2 then
                
                TriggerServerEvent("MenuTest")
                end
            end
        end
end)