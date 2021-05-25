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
Tunnel.bindInterface("shops",cnVRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,weight,maxweight,infos = vSERVER.requestShop(data.shop)
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data,cb)
	vSERVER.functionShops(data.shop,data.item,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:Update")
AddEventHandler("shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DEPARTAMENTSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:departamentStore",function()
	if GetClockHours() >= 15 and GetClockHours() <= 20 then
		SendNUIMessage({ action = "showNUI", name = tostring("departamentStore"), type = vSERVER.getShopType("departamentStore") })
		SetNuiFocus(true,true)
	else
		TriggerEvent("Notify","amarelo","Loja fechada, a mesma só funciona das <b>15</b> ás <b>20</b> horas.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:AMMUNATIONSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:ammunationStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("ammunationStore"), type = vSERVER.getShopType("ammunationStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:NORMALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:normalpharmacyStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("normalpharmacyStore"), type = vSERVER.getShopType("normalpharmacyStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOSPITALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hospitalpharmacyStore",function()
	if vSERVER.requestPerm("hospitalpharmacyStore") then
		SendNUIMessage({ action = "showNUI", name = tostring("hospitalpharmacyStore"), type = vSERVER.getShopType("hospitalpharmacyStore") })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("coffeeMachine"), type = vSERVER.getShopType("coffeeMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("sodaMachine"), type = vSERVER.getShopType("sodaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("donutMachine"), type = vSERVER.getShopType("donutMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("burgerMachine"), type = vSERVER.getShopType("burgerMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("hotdogMachine"), type = vSERVER.getShopType("hotdogMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("waterMachine"), type = vSERVER.getShopType("waterMachine") })
	SetNuiFocus(true,true)
end)