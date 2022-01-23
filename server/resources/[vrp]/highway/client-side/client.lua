local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

hwVRP = {}
Tunnel.bindInterface("hwmec", hwVRP)
vSERVER= Tunnel.getInterface("hwmec")

Citizen.CreateThread(function()

    local oti = 0

    while true do
        for i = 1, #locations, 1 do
            local loc = locations[i]
            DrawMarker(loc.type, loc.pos.x, loc.pos.y, loc.pos.z + 2,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            loc.scale, loc.scale, loc.scale,
            loc.rgba.r, loc.rgba.g, loc.rgba.b, loc.rgba.a,
            false, true, 2, nil, nil, false)
            
            local plrPos = GetEntityCoords(PlayerPedId(), false)
            local locPos = vector3(loc.pos.x, loc.pos.y, loc.pos.z)
            
            oti = 4
            
            if vRP.checkDist(plrPos, locPos) < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(),false) ~= nil then
                oti = 4
                hwVRP.Drawtext("~w~PRESSIONE ~y~E~w~ PARA TUNAR", 0.95)
            end
            
        end
        Citizen.Wait(oti)
    end

end)

Citizen.CreateThread(function()
    while true do
        local oti = 5
        if IsControlJustPressed(1,38) then
            TriggerServerEvent("hwmods:open")
        end
        Citizen.Wait(oti)
    end
end)

RegisterCommand("hwmods:open",function (source, args)
    if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
        SetNuiFocus(true,true)
        SetCursorLocation(0.5,0.5)
        SendNuiMessage({action = "showMenu"})
    end
end)

function hwVRP.Drawtext(text, height)
    SetTextFont(4)
    SetTextScale(0.50,0.50)
    SetTextColour(255,255,255,180)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5,height)
end