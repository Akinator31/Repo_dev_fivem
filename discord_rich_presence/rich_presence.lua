Citizen.CreateThread(function()
    while true do
        -- This is the Application ID (Replace this with you own)
        SetDiscordAppId(1120626949832835144)

        -- Here you will have to put the image name for the "large" icon.
        SetDiscordRichPresenceAsset('logo_server')

        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Serveur test')

        Citizen.Wait(60000)
    end
end)