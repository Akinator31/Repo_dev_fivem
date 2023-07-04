RegisterServerEvent('blips:takeBlip', function(x, y, z)
    print(string.format("[Blip changed]: updated coords to (x=%s, y=%s, z=%s", x, y, z))
    TriggerClientEvent('blips:setBlip', -1, x, y, z)
end)