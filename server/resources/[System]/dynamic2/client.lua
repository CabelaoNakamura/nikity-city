-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("dynamic",cnVRP)
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moremenu", function(source, args, raw)
    TriggerEvent("dynamic:Menu")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moremenu","Abrir o menu","keyboard","f7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:Menu', function()
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "Outros",
            txt = "Todas as funções do personagem",
            params = {
                event = "dynamic:InfoMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('dynamic:InfoMenu', function(data)
    TriggerEvent('dynamic:sendMenu', {
        {
            id = 1,
            header = "Voltar                                                  <i class='fas fa-chevron-left'></i>",
            txt = "Volte ao menu anterior",
			params = {
                event = "dynamic:Menu"
            }
        },
        {
            id = 2,
            header = "Informações",
            txt = "Todas as informações de sua identidade",
			params = {
                event = "dynamic:MyInfos",
            }
        }
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMICEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('dynamic:MyInfos', function()
local infos = vSERVER.getInfos()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)

RegisterNetEvent('dynamic:sendMenu', function(data)
    if not data then return end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
