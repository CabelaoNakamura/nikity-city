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
Tunnel.bindInterface("player",cnVRP)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockCommands = false
RegisterNetEvent("player:blockCommands")
AddEventHandler("player:blockCommands",function(status)
	blockCommands = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKS
-----------------------------------------------------------------------------------------------------------------------------------------
function blocks()
	return blockCommands
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockCommands",blocks)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
					SetPedConfigFlag(ped,184,true)
					SetVehicleCloseDoorDeferedAction(veh,0)
				end
			end
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMADEATH
-----------------------------------------------------------------------------------------------------------------------------------------
local dX,dY,dZ = 294.78,-1351.17,24.54
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(dX,dY,dZ))
			if distance <= 2.5 then
				timeDistance = 4
				DrawText3D(dX,dY,dZ,"~y~E~w~  DELETAR PERSONAGEM")
				DrawMarker(23,dX,dY,dZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,25,0,0,0,0)
				if IsControlJustPressed(1,38) then
					vSERVER.deleteChar()
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		TriggerServerEvent("player:salary")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler("cancelando",function(status)
	cancelando = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if cancelando then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
			DisableControlAction(1,37,true)
			DisableControlAction(1,38,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.setDiving()
	local ped = PlayerPedId()
	if IsPedSwimming(ped) then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,8,123,0,2)
			SetPedPropIndex(ped,1,26,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,8,153,0,2)
			SetPedPropIndex(ped,1,28,0,2)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				timeDistance = 4
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetic = 0
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)
	energetic = energetic + timers
	SetRunSprintMultiplierForPlayer(PlayerId(),number)
end)

Citizen.CreateThread(function()
	while true do
		if energetic > 0 then
			RestorePlayerStamina(PlayerId(),1.0)
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		if energetic > 0 then
			energetic = energetic - 1

			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
				energetic = 0
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 10

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)

			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0

				TriggerServerEvent("upgradeStress",100)
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local methanfetamine = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	methanfetamine = methanfetamine + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if methanfetamine > 0 then
			methanfetamine = methanfetamine - 1

			if methanfetamine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				methanfetamine = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local cocaine = 0
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine",function()
	cocaine = cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if cocaine > 0 then
			cocaine = cocaine - 1

			if cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = drunkTime + timers

	TriggerEvent("vrp:blockDrunk",true)
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

Citizen.CreateThread(function()
	while true do
		if drunkTime > 0 then
			drunkTime = drunkTime - 1

			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				TriggerEvent("vrp:blockDrunk",false)
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,4,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehIndex,status)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if status == "1" then
				RollUpWindow(v,0)
				RollUpWindow(v,1)
			else
				RollDownWindow(v,0)
				RollDownWindow(v,1)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(vehIndex,door)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleDoorsLockedForPlayer(v,PlayerId()) ~= 1 then
			if door == "1" then
				if GetVehicleDoorAngleRatio(v,0) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
				else
					SetVehicleDoorShut(v,0,0)
				end
			elseif door == "2" then
				if GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,1,0,0)
				else
					SetVehicleDoorShut(v,1,0)
				end
			elseif door == "3" then
				if GetVehicleDoorAngleRatio(v,2) == 0 then
					SetVehicleDoorOpen(v,2,0,0)
				else
					SetVehicleDoorShut(v,2,0)
				end
			elseif door == "4" then
				if GetVehicleDoorAngleRatio(v,3) == 0 then
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,3,0)
				end
			elseif door == "5" then
				if GetVehicleDoorAngleRatio(v,5) == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			elseif door == "6" then
				if GetVehicleDoorAngleRatio(v,4) == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
	if args[1] == "on" then
		SetTimecycleModifier("cinema")
	else
		ClearTimecycleModifier()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcuff",function(source,args)
	vSERVER.cuffToggle()
end)
RegisterKeyMapping("keybindcuff","Algemar o Cidadao","keyboard","g")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcarry",function(source,args)
	vSERVER.carryToggle()
end)
RegisterKeyMapping("keybindcarry","Carregar o Cidadao","keyboard","h")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Disabled"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Disabled"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Disabled"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Disabled"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 4 then
			suspensao = "Nível 5 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Disabled"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","default","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Lataria:</b> "..parseInt(body/10).."%<br><b>Motor:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false
function cnVRP.toggleHandcuff()
	if not handcuff then
		handcuff = true
		TriggerEvent("radio:outServers")
		exports["smartphone"]:closeSmartphone()
	else
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.removeHandcuff()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getHandcuff()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function handcuffs()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
exports("handCuff",handcuffs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEMENTCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.movementClip(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if handcuff then
			timeDistance = 4
			DisableControlAction(1,18,true)
			DisableControlAction(1,21,true)
			DisableControlAction(1,55,true)
			DisableControlAction(1,102,true)
			DisableControlAction(1,179,true)
			DisableControlAction(1,203,true)
			DisableControlAction(1,76,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisablePlayerFiring(ped,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYROPE
-----------------------------------------------------------------------------------------------------------------------------------------
local startRope = false
RegisterNetEvent("player:applyRope")
AddEventHandler("player:applyRope",function(status)
	startRope = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if handcuff and GetEntityHealth(ped) > 101 and not startRope then
			if not IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end

				TaskPlayAnim(ped,"mp_arresting","idle",3.0,3.0,-1,49,0,0,0,0)
				timeDistance = 4
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local coolTimers = 0
local residual = false
local policeService = false
local sprayTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISABLECTRL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if coolTimers > 0 then
			timeDistance = 4
			DisableControlAction(1,36,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if coolTimers > 0 then
			coolTimers = coolTimers - 1
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and IsPedArmed(ped,6) then
			timeDistance = 4

			if IsPedShooting(ped) then
				ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.10)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYGSR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:applyGsr")
AddEventHandler("player:applyGsr",function()
	residual = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.gsrCheck()
	return residual
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkSoap()
	local ped = PlayerPedId()
	if IsEntityInWater(ped) and residual then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANRESIDUAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.cleanResidual()
	residual = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cnVRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if iCarry then
			iCarry = false
			DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		end

		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:SPAWNSEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:spawnSeat")
AddEventHandler("player:spawnSeat",function(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			SetPedIntoVehicle(PlayerPedId(),v,-1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.putVehicle(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			local vehSeats = 5
			local ped = PlayerPedId()

			repeat
				vehSeats = vehSeats - 1

				if IsVehicleSeatFree(v,vehSeats) then
					ClearPedTasks(ped)
					ClearPedSecondaryTask(ped)
					SetPedIntoVehicle(ped,v,vehSeats)

					if iCarry then
						iCarry = false
						DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
					end

					vehSeats = true
				end
			until vehSeats == true or vehSeats == 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.toggleLivery(number)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		SetVehicleLivery(GetVehiclePedIsUsing(ped),number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
local trunkPlate = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function()
	local ped = PlayerPedId()

	if not IsPedInAnyVehicle(ped) then
		if not inTrunk then
			local vehicle,vehNet,vehPlate = vRP.vehList(10)
			if DoesEntityExist(vehicle) and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
				if vSERVER.insertTrunk(vehPlate) then
					local trunk = GetEntityBoneIndexByName(vehicle,"boot")
					local speed = GetEntitySpeed(vehicle) * 2.236936
					if trunk ~= -1 and speed <= 3 then
						local coords = GetEntityCoords(ped)
						local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
						local distance = #(coords - coordsEnt)
						if distance <= 3.0 then
							timeDistance = 4
							if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
								trunkPlate = vehPlate
								SetCarBootOpen(vehicle)
								SetEntityVisible(ped,false,false)
								Citizen.Wait(750)
								AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
								Citizen.Wait(500)
								SetVehicleDoorShut(vehicle,5)
								blockCommands = true
								inTrunk = true
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blackWeapons = {
	"WEAPON_UNARMED",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN",
	"GADGET_PARACHUTE",
	"WEAPON_PETROLCAN",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedArmed(ped,6) and GetGameTimer() >= (sprayTimers + 60000) and GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_MUSKET") then
			timeDistance = 4

			if IsPedShooting(ped) then
				sprayTimers = GetGameTimer()
				residual = true
				coolTimers = 3

				local coords = GetEntityCoords(ped)
				if not policeService then
					vSERVER.shotsFired()
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local shotDistance = {
	{ -186.1,-893.5,29.3,2500 },
	{ 1389.7,3237.2,37.6,1300 },
	{ -137.4,6228.4,31.2,1000 }
}

function cnVRP.shotDistance(x,y,z)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(shotDistance) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= v[4] then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cnVRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		iCarry = false
		DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.extraVehicle(data)
	local vehicle = vRP.getNearVehicle(11)
	if data == "1" then
		if DoesExtraExist(vehicle,1) then
			if IsVehicleExtraTurnedOn(vehicle,1) then
				SetVehicleExtra(vehicle,1,true)
			else
				SetVehicleExtra(vehicle,1,false)
			end
		end
	elseif data == "2" then
		if DoesExtraExist(vehicle,2) then
			if IsVehicleExtraTurnedOn(vehicle,2) then
				SetVehicleExtra(vehicle,2,true)
			else
				SetVehicleExtra(vehicle,2,false)
			end
		end
	elseif data == "3" then
		if DoesExtraExist(vehicle,3) then
			if IsVehicleExtraTurnedOn(vehicle,3) then
				SetVehicleExtra(vehicle,3,true)
			else
				SetVehicleExtra(vehicle,3,false)
			end
		end
	elseif data == "4" then
		if DoesExtraExist(vehicle,4) then
			if IsVehicleExtraTurnedOn(vehicle,4) then
				SetVehicleExtra(vehicle,4,true)
			else
				SetVehicleExtra(vehicle,4,false)
			end
		end
	elseif data == "5" then
		if DoesExtraExist(vehicle,5) then
			if IsVehicleExtraTurnedOn(vehicle,5) then
				SetVehicleExtra(vehicle,5,true)
			else
				SetVehicleExtra(vehicle,5,false)
			end
		end
	elseif data == "6" then
		if DoesExtraExist(vehicle,6) then
			if IsVehicleExtraTurnedOn(vehicle,6) then
				SetVehicleExtra(vehicle,6,true)
			else
				SetVehicleExtra(vehicle,6,false)
			end
		end
	elseif data == "7" then
		if DoesExtraExist(vehicle,7) then
			if IsVehicleExtraTurnedOn(vehicle,7) then
				SetVehicleExtra(vehicle,7,true)
			else
				SetVehicleExtra(vehicle,7,false)
			end
		end
	elseif data == "8" then
		if DoesExtraExist(vehicle,8) then
			if IsVehicleExtraTurnedOn(vehicle,8) then
				SetVehicleExtra(vehicle,8,true)
			else
				SetVehicleExtra(vehicle,8,false)
			end
		end
	elseif data == "9" then
		if DoesExtraExist(vehicle,9) then
			if IsVehicleExtraTurnedOn(vehicle,9) then
				SetVehicleExtra(vehicle,9,true)
			else
				SetVehicleExtra(vehicle,9,false)
			end
		end
	elseif data == "10" then
		if DoesExtraExist(vehicle,10) then
			if IsVehicleExtraTurnedOn(vehicle,10) then
				SetVehicleExtra(vehicle,10,true)
			else
				SetVehicleExtra(vehicle,10,false)
			end
		end
	elseif data == "11" then
		if DoesExtraExist(vehicle,11) then
			if IsVehicleExtraTurnedOn(vehicle,11) then
				SetVehicleExtra(vehicle,11,true)
			else
				SetVehicleExtra(vehicle,11,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.putVehicle(seat)
	local veh = vRP.getNearVehicle(11)
	if IsEntityAVehicle(veh) then
		if parseInt(seat) <= 1 or seat == nil then
			seat = -1
		elseif parseInt(seat) == 2 then
			seat = 0
		elseif parseInt(seat) == 3 then
			seat = 1
		elseif parseInt(seat) == 4 then
			seat = 2
		elseif parseInt(seat) == 5 then
			seat = 3
		elseif parseInt(seat) == 6 then
			seat = 4
		elseif parseInt(seat) == 7 then
			seat = 5
		elseif parseInt(seat) >= 8 then
			seat = 6
		end

		local ped = PlayerPedId()
		if IsVehicleSeatFree(veh,seat) then
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			SetPedIntoVehicle(ped,veh,seat)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOLSTER
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	"WEAPON_KNIFE",
	"WEAPON_HATCHET",
	"WEAPON_RPG",
	"WEAPON_RAYPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_COMBATPISTOL",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_SMG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG"
}

local holster = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped) then
			if CheckWeapon(ped) then
				if not holster then
					timeDistance = 4
					if not IsEntityPlayingAnim(ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
						loadAnimDict("rcmjosh4")
						TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)
						Citizen.Wait(450)
						ClearPedTasks(ped)
					end
					holster = true
				end
			elseif not CheckWeapon(ped) then
				if holster then
					timeDistance = 4
					if not IsEntityPlayingAnim(ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
						loadAnimDict("weapons@pistol@")
						TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)
						Citizen.Wait(450)
						ClearPedTasks(ped)
					end
					holster = false
				end
			end
		end

		if GetEntityHealth(ped) <= 101 and holster then
			holster = false
			SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		end
		Citizen.Wait(timeDistance)
	end
end)

function CheckWeapon(ped)
	for i = 1,#weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.toggleLivery(number)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		SetVehicleLivery(GetVehiclePedIsUsing(ped),number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	if inTrunk then
		local ped = PlayerPedId()
		local vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(vehicle) then
			vSERVER.removeTrunk(trunkPlate)
			SetCarBootOpen(vehicle)
			Citizen.Wait(750)
			inTrunk = false
			blockCommands = false
			DetachEntity(ped,false,false)
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.25),1,0,0,0)
			Citizen.Wait(500)
			SetVehicleDoorShut(vehicle,5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500

		if inTrunk then
			local ped = PlayerPedId()
			local vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(vehicle) then
				timeDistance = 4

				DisablePlayerFiring(ped,true)

				if IsEntityVisible(ped) then
					SetEntityVisible(ped,false,false)
				end

				if IsControlJustPressed(1,38) then
					vSERVER.removeTrunk(trunkPlate)
					SetCarBootOpen(vehicle)
					Citizen.Wait(750)
					inTrunk = false
					blockCommands = false
					DetachEntity(ped,false,false)
					SetEntityVisible(ped,true,false)
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.25),1,0,0,0)
					Citizen.Wait(500)
					SetVehicleDoorShut(vehicle,5)
				end
			else
				inTrunk = false
				blockCommands = false
				DetachEntity(ped,false,false)
				vSERVER.removeTrunk(trunkPlate)
				SetEntityVisible(ped,true,false)
				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.25),1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,args)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped and not IsEntityInAir(veh) then
				local speed = GetEntitySpeed(veh) * 2.236936

				if speed >= 0 then
					if args[1] == nil then
						SetEntityMaxSpeed(veh,GetVehicleEstimatedMaxSpeed(veh))
						TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
					else
						if parseInt(args[1]) > 0 then
							SetEntityMaxSpeed(veh,0.45*args[1])
							TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
						end
					end
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local disService = {
	{ 1146.9,-1542.8,35.39,"Paramedic" },
	{ -198.22,-1317.91,31.09,"Mechanic" },
	{ 362.84,-1588.72,29.3,"Police" } -- Sandy Shores
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.distanceService()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(disService) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 15 then
			return true,v[4]
		end
	end
	return false,nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.weColors(number)
	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	SetPedWeaponTintIndex(ped,weapon,parseInt(number))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
local wLux = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_PISTOL_VARMOD_LUXE"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_APPISTOL_VARMOD_LUXE"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_HEAVYPISTOL_VARMOD_LUXE"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_MICROSMG_VARMOD_LUXE"
	},
	["WEAPON_SNSPISTOL"] = {
		"COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_PISTOL50_VARMOD_LUXE"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_CARBINERIFLE_VARMOD_LUXE"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		"COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_SMG_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.weLux()
	local ped = PlayerPedId()
	for k,v in pairs(wLux) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
local inCamera = false
local camSelect = nil
local coords = nil
local cameras = {
	["1"] = { 433.72,-978.4,34.71,112.67 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 },
	["4"] = { 148.99,-1036.29,32.34,306.15 },
	["5"] = { 1171.59,-1499.12,40.85,138.9 },
	["6"] = { 1145.03,-1529.39,37.38,144.57 },
	["7"] = { 73.09,-964.68,35.35,133.23 }
}

RegisterNetEvent("player:serviceCamera")
AddEventHandler("player:serviceCamera",function(num)
	local ped = PlayerPedId()

	if not IsPedInAnyVehicle(ped) then
		if inCamera then
			ClearTimecycleModifier()
			DestroyCam(camSelect,false)
			SetEntityInvincible(ped,false)
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,coords,1,0,0,0)
			FreezeEntityPosition(ped,false)
			TriggerEvent("hudActived",true)
			RenderScriptCams(false,false,0,1,0)
			PlaySoundFrontend(-1,"HACKING_SUCCESS",false)

			inCamera = false
			camSelect = nil
		else
			if cameras[num] then
				inCamera = true
				coords = GetEntityCoords(ped)
				SetEntityInvincible(ped,true)
				SetEntityVisible(ped,false,false)
				SetEntityCoords(ped,cameras[num][1],cameras[num][2],cameras[num][3],1,0,0,0)
				FreezeEntityPosition(ped,true)
				TriggerEvent("hudActived",false)
				SetTimecycleModifier("heliGunCam")
				PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
				camSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
				SetCamCoord(camSelect,cameras[num][1],cameras[num][2],cameras[num][3])
				SetCamRot(camSelect,-20.0,0.0,cameras[num][4])
				RenderScriptCams(true,false,0,1,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MERCOSULPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
imageUrl = "nui://player/web-side/images/mercosul.png"

local textureDic = CreateRuntimeTxd('duiTxd')
local object = CreateDui(imageUrl, 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex')


local object = CreateDui('nui://player/web-side/images/plate.png', 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle)
AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2')