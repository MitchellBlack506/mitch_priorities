function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end
function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)    
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*15
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)		-- You can change the text color here
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function spawnCar(car)
        local car = GetHashKey(car)
        RequestModel(car)
        local waiting = 0
        while not HasModelLoaded(car) do
            RequestModel(car)
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 9000 then
                notify("~r~Could not spawn car: ~h~~g~" .. data.spawncode .. " Contact an administrator")
                break
            end        
        end
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            SetEntityAsMissionEntity(Object, 1, 1)
            SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), false), 1, 1)
            DeleteEntity(Object)
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
        end

        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
        local vehicle = CreateVehicle(car, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
end