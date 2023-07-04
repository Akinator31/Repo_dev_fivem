RegisterNetEvent("onJoin")

AddEventHandler("onJoin", function ()
    local _src = source
    print("^2[JOIN] ^7Le joueur ^1"..GetPlayerName(_src).." ^7vient de se connecter !")

    MySQL.Async.fetchAll("SELECT * FROM usersData WHERE name = @name", {
        ["@name"] = GetPlayerName(_src)
    }, function (result)
        if result[1] then
            print("^2[JOIN] ^7Le joueur ^1"..GetPlayerName(_src).." ^7est déjà enregistré dans la base de données !")
        else
            MySQL.Async.execute("INSERT INTO usersData (name, id) VALUES (@name, @id)", {
                ["@name"] = GetPlayerName(_src),
                ["@id"] = _src
            }, function ()
                print("^2[JOIN] ^7Le joueur ^1"..GetPlayerName(_src).." ^7a été enregistré dans la base de données !")

            end)
        end
        
    end)
end)