_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Menu Boss", "~b~EBoueur")
_menuPool:Add(mainMenu)
bool = false

local checkbox = NativeUI.CreateCheckboxItem("Activer le job", bool, "Activer ou désactiver le job d'eboueur")
menu:AddItem(checkbox)
menu.OnCheckboxChange = function(sender, item, checked_)
    if item == checkbox then
        bool = checked_
        notify(tostring(bool))
    end
end    

_menuPool:RefreshIndex()

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 51) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)