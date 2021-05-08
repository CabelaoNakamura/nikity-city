-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
yRP = {}
Tunnel.bindInterface("easytime",yRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Weather = 'CLEAR'
local LastWeather = false
local Dynamic = Config.DynamicWeather
local Blackout = false
local FreezeTime = false
local Hours = 09
local Mins = 00
local LastWeatherTable = {}
local WeatherCounter = 0
local TimesChanged = 0
local HasTriggered = false
local TimeCounter = 0
local Group = Config.WeatherGroups[1]
local LastGroup = Config.WeatherGroups[1]
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("changetime", function(source)
    local _source = source
    if PermissionsCheck(_source) then
        TriggerClientEvent('cd_easytime:OpenUI', _source, {weather = Weather, time = Hours, mins = Mins, dynamic = Dynamic, blackout = Blackout, freeze = FreezeTime})
    else
        Notification(_source, Config.Locales[Config.Language]['invalid_permissions'])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchangetime = "https://discord.com/api/webhooks/839904802410201159/-B-7hsesI7jYGE3Ay6u6TxwM6GE3URRUE3XJFRMRy7gynbTBuTWOWJvAO4ZsbRj2eEop"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerClientEvent('cd_easytime:SyncAll', -1, {weather = Weather, hours = Hours, mins = Mins, dynamic = Dynamic, blackout = Blackout, freeze = FreezeTime})
end)

RegisterServerEvent('cd_easytime:SyncMe')
AddEventHandler('cd_easytime:SyncMe', function()
    local _source = source
    TriggerClientEvent('cd_easytime:SyncAll', _source, {weather = Weather, hours = Hours, mins = Mins, dynamic = Dynamic, blackout = Blackout, freeze = FreezeTime})
end)

RegisterServerEvent('cd_easytime:ForceUpdate')
AddEventHandler('cd_easytime:ForceUpdate', function(data)
    local user_id = vRP.getUserId(source)
    local _source = source
    if PermissionsCheck(_source) then
        if data.hours ~= nil then
            Hours = tonumber(data.hours)
        end
        if data.weather ~= nil and Config.DynamicWeather then
            Weather = tostring(data.weather)
            local shouldstop = false
            TimesChanged = 0
            LastWeatherTable = nil
            LastWeatherTable = {}
            for k, v in pairs(Config.WeatherGroups) do
                if shouldstop then
                    break
                end
                for k, w in pairs(v) do
                    if w == Weather then
                        shouldstop = true
                        Group = v
                        break
                    end
                end
            end
            for k, n in pairs(Group) do
                if n == Weather then
                    break
                end
                TimesChanged = TimesChanged+1
                LastWeatherTable[n] = n
            end
        end
        if data.dynamic ~= nil then
            Dynamic = data.dynamic
        end
        if data.blackout ~= nil then
            Blackout = data.blackout
        end
        if data.freeze ~= nil then
            FreezeTime = data.freeze
        end
        TriggerClientEvent('cd_easytime:ForceUpdate', -1, {weather = Weather, hours = tonumber(data.hours), mins = Mins, dynamic = Dynamic, blackout = Blackout, freeze = FreezeTime})
		PerformHttpRequest(webhookchangetime, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					fields = {
						{ 
							name = "Informações sobre a mudança de tempo:",
							value = "```O tempo do jogo foi setado como "..Weather..", pelo ID "..user_id..".```"
						}
					}, 
					footer = { 
						text = os.date("%d/%m/%Y ás %H:%M:%S")
					},
					color = 47359 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    else
        DropPlayer(source, 'Porque você fez isso?')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.TimeCycleSpeed)
        if not FreezeTime then
            TimeCounter = TimeCounter+1
            Mins = Mins+1
            if Mins >= 60 then Mins = 0 Hours = Hours+1 end
            if Hours >= 24 then Hours = 0 end

            if TimeCounter == 5 then
                HasTriggered = false
            end
            if not HasTriggered then
                HasTriggered = true
                TimeCounter = 0
                TriggerClientEvent('cd_easytime:SyncTime', -1, {hours = Hours, mins = Mins})
            end
        end

        if Config.DynamicWeather and Dynamic and not shouldstop then
            WeatherCounter = WeatherCounter+1
            if WeatherCounter >= (Config.DynamicWeather_time*60*1000/Config.TimeCycleSpeed) then
                WeatherCounter = 0
                if #Group >= TimesChanged then
                    local TableCleared = true
                    for k, v in pairs(Group) do
                        if LastWeatherTable[v] == nil then
                            if v == 'THUNDER' and math.random(1,100) > Config.ThunderChance then
                                break
                            end
                            TimesChanged = TimesChanged+1
                            LastWeatherTable[v] = v
                            Weather = v
                            TriggerClientEvent('cd_easytime:SyncWeather', -1, {weather = Weather, blackout = Blackout})
                            print('^3O tempo mudou para: '..Weather..'.^0')
                            TableCleared = false
                            break
                        end
                    end
                    Wait(0)
                    if TableCleared then
                        Group = ChooseWeatherType()
                        TimesChanged = 0
                        LastWeatherTable = nil
                        LastWeatherTable = {}
                    end 
                    LastGroup = Group
                end
            end
        end
    end
end)
     
function ChooseWeatherType()
    local result = math.random(1,#Config.WeatherGroups)
    if result == 2 then
        if math.random(1,100) <= Config.RainChance then
            return Config.WeatherGroups[result]
        else
            local StartLoop = true
            while StartLoop do
                Wait(0)
                local finalaresult = math.random(1,#Config.WeatherGroups)
                if finalaresult ~= result and finalaresult ~= 4 then
                    StartLoop = false
                    return Config.WeatherGroups[finalaresult]
                end
            end
        end
    elseif result == 3 then
        if LastGroup == Config.WeatherGroups[result] then
            return Config.WeatherGroups[1]
        else
            return Config.WeatherGroups[result]
        end
    elseif result == 4 then
        if math.random(1,100) <= Config.SnowChance then
            return Config.WeatherGroups[result]
        else
            local StartLoop = true
            while StartLoop do
                Wait(0)
                local finalaresult = math.random(1,#Config.WeatherGroups)
                if finalaresult ~= result and finalaresult ~= 2 then
                    StartLoop = false
                    return Config.WeatherGroups[finalaresult]
                end
            end
        end
    else
        return Config.WeatherGroups[result]
    end 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function PermissionsCheck(source)
    local user_id = vRP.getUserId(source)
        if vRP.hasPermission(user_id, "Owner") then
            return true
        else
            return false
        end
end