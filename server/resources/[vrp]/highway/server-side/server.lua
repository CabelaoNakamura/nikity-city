local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

hwVRP = {}
Tunnel.bindInterface("hwmec", hwVRP)
vCLIENT = Tunnel.getInterface("hwmec")


RegisterNetEvent("hwmods:open")
AddEventHandler("hwmods:open", function(user_id, status)
    local user_id = vRP.getUserId(user_id)

    if user_id then
        if vRP.hasPermission(user_id, "hwmec") or vRP.hasPermission(user_id, "Admin") then
            ExecuteCommand("hwmods:open")
        end
    end

end, false)