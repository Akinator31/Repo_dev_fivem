-- Enregistrement des évènements pour le job eboueurjob

RegisterNetEvent("RegisterJobForPlayer") -- Enregistrement du joueur dans la base de données si il n'y est pas déjà
RegisterNetEvent("startJob") -- Début du service du joueur
RegisterNetEvent("finishJob") -- Fin du service du joueur

-- Création des évènements pour le job eboueurjob

AddEventHandler("RegisterJobForPlayer", function () -- Enregistrement du joueur dans la base de données si il n'y est pas déjà

    local _src = source
    
    print("^3[JOB] ^7Le joueur ^1"..GetPlayerName(_src).." ^7vient de commencer le métier d'éboueur !")

    MySQL.Async.fetchAll("SELECT * FROM eboueurjob WHERE name = @name", {
        ["@name"] = GetPlayerName(_src)
    }, function (result)
        
        if result[1] then
            print("^2[JOIN] ^7Le joueur ^1"..GetPlayerName(_src).." ^7est déjà enregistré dans la base de données !")
        else
            MySQL.Async.execute("INSERT INTO eboueurjob (name, id, working, money) VALUES (@name, @id, @working, @money)", {
                ["@name"] = GetPlayerName(_src),
                ["@id"] = _src,
                ["@working"] = 1,
                ["@money"] = 0
            }, function ()
                print("^2[JOIN] ^7Le joueur ^1"..GetPlayerName(_src).." ^7a été enregistré dans la base de données !")

            end)
        end
end)

AddEventHandler("startJob", function () -- Début du service du joueur
    
    local setWorking = 1

    local _src = source
    
    print("^3[JOB] ^7Le joueur ^1"..GetPlayerName(_src).." ^7vient de commencer le métier d'éboueur !")
          

    local requeteStart = [[
        UPDATE eboueurjob
        SET working = ?
        WHERE id = ?
    ]]

    MySQL.Async.execute(requeteStart, {setWorking, _src}, function ()
        print("^2[JOB] ^7Le joueur ^1"..GetPlayerName(_src).." ^7vient de commencer son service !")
        end)
    end)
end)

AddEventHandler("finishJob", function () -- Fin du service du joueur

    local _src = source

    local setWorking = 0

    local requeteFinish = [[
        UPDATE eboueurjob
        SET working = ?
        WHERE id = ?
    ]]

    MySQL.Async.execute(requeteFinish, {setWorking, _src}, function ()
        print("^2[JOB] ^7Le joueur ^1"..GetPlayerName(_src).." ^7vient de finir son service !")
        
    end)
end)