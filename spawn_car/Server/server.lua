RegisterNetEvent("giveMoney")

AddEventHandler("giveMoney", function (moneyGived)
    local _src = source

    print("test fonction")
    print(moneyGived)

    local requete = [[
        UPDATE eboueurjob
        SET money = money + ?
        WHERE id = ?
    ]]

    MySQL.Async.execute(requete, {moneyGived, _src}, function ()
        print("^2[JOB] ^7Le joueur ^1"..GetPlayerName(_src).." ^7a reçu ^1"..moneyGived.." ^7$ !")
    end)
end)