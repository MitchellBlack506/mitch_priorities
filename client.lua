currentPriority = false
onDuty = false

RegisterNetEvent('mitchPriorities:currentPriority:Return')
AddEventHandler('mitchPriorities:currentPriority:Return', function(bool)
    currentPriority = bool
end)

RegisterCommand("onduty", function()
    onDuty = not onDuty
    if onDuty then 
        exports['mythic_notify']:DoCustomHudText('inform', 'Now on duty!',2500, { ['background-color'] = '#90dbf4', ['color'] = '#001219' })
    else
        exports['mythic_notify']:DoCustomHudText('inform', 'Now off duty!',2500, { ['background-color'] = '#90dbf4', ['color'] = '#001219' })
    end
end)

RegisterNetEvent('mitchPriorities.currentPriority:OnDutyAlert')
AddEventHandler('mitchPriorities.currentPriority:OnDutyAlert',function(locations)
    if onDuty then
        print("^1Received priority : ".. locations.name)
        locations.blip = AddBlipForCoord(locations.coords.x, locations.coords.y, locations.coords.z)
        SetBlipSprite(locations.blip, 161)
        SetBlipColour(locations.blip,1)
        SetBlipAsShortRange(locations.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(locations.name)
        EndTextCommandSetBlipName(locations.blip)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        exports['mythic_notify']:DoCustomHudText('inform', 'There has been a priority reported at '..locations.name..".",10000, { ['background-color'] = '#90dbf4', ['color'] = '#001219' })
        Wait(1000 * config.cooldown) -- 10 seconds 
        RemoveBlip(locations.blip)    
    end  
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
            local localCoords = GetEntityCoords(GetPlayerPed(-1))
            for _, locations in pairs(config.locations) do
                if GetDistanceBetweenCoords(localCoords.x, localCoords.y, localCoords.z, locations.coords.x, locations.coords.y, locations.coords.z, true) < 5.0 then
                    if not onDuty then
                        if currentPriority == false then
                            
                            Draw3DText(locations.coords.x, locations.coords.y, locations.coords.z, locations.text,4,0.15,0.1)
                            if IsControlJustReleased(0, 38) then -- E key
                                TriggerServerEvent('mitchPriorities:startPriority', true,locations)
                                print("Successfully started priority")
                                exports['mythic_notify']:DoCustomHudText('inform', 'Started robbing '..locations.name..". Police have been alerted!",10000, { ['background-color'] = '#90dbf4', ['color'] = '#001219' })
                            end
                        else
                            Draw3DText(locations.coords.x, locations.coords.y, locations.coords.z, "~r~Cops have been alerted about a possible robbery!!",4,0.15,0.1)
                        end
                    else
                        Draw3DText(locations.coords.x, locations.coords.y, locations.coords.z, "~m~You may not rob this whilst on duty!",4,0.15,0.1)
                    end 
                end
        end
    end
end)


function chat(str, color)
    TriggerEvent("chat:addMessage", {
        color = color,
        multiline= true,
        args = {str}
    })
end

function chatMessage(str, color)
    TriggerEvent("chat:addMessage", {
        color = color,
        multiline= true,
        args = {str}
    })
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerServerEvent('mitchPriorities:currentPriority')
	end
end)