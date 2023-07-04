-- On fait en sorte que la position du joueur soit sauvegarder quand il se déconnecte

AddEventHandler("playerDropped", function()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    TriggerServerEvent("savepos", pos.x, pos.y, pos.z)
end)

-- On fait en sorte que la position du joueur soit la même que celle sauvegarder quand il se connecte

RegisterNetEvent("loadpos")
AddEventHandler("loadpos", function(x, y, z)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, x, y, z)
end)

