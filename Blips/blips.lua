blip = nil

function initializeBlip()

    local blipName = "Job eboueur"
    local blipCoords = coordsBlip[blipName]
    blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
    SetBlipScale(blip, 1.0)
    SetBlipSprite(blip, 318)
    SetBlipColour(blip, 47)
    SetBlipAlpha(blip, 255)
    AddTextEntry("MYBLIP", "Métier d'eboueur")
    BeginTextCommandSetBlipName("MYBLIP")
    EndTextCommandSetBlipName(blip)
    SetBlipCategory(blip, 2)
    SetBlipAsShortRange(blip, true)
    print("Blip initialized")
    
end

Citizen.CreateThread(function()
    initializeBlip()
end)

RegisterCommand("removeBlip", function(source, args)
    if DoesBlipExist(blip) then
        TriggerServerEvent('blips:takeBlip')
    end
end, false)

RegisterCommand("bliptome", function(source, args)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    TriggerServerEvent('blips:takeBlip', x, y, z)
end, false)

RegisterNetEvent('blips:setBlip', function (x, y, z)
    if DoesBlipExist(blip) and x ~= nil then
        SetBlipCoords(blip, x, y, z)
        SetBlipAsShortRange(blip, true)
        SetBlipHiddenOnLegend(blip, true)
    else
        RemoveBlip(blip)
        blip = nil
    end
end)