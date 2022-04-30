print("================================")
print("=  Priorities script by Mitch  =")
print("================================")

currentPriority = false
RegisterNetEvent('mitchPriorities:currentPriority')
AddEventHandler('mitchPriorities:currentPriority', function()
	-- Check if active or not
	if currentPriority then
		-- There is a priority
		TriggerClientEvent('mitchPriorities:currentPriority:Return', source, true)
	else
		-- There isn't a priority
		TriggerClientEvent('mitchPriorities:currentPriority:Return', source, false)
	end
end)

RegisterNetEvent('mitchPriorities:startPriority')
AddEventHandler('mitchPriorities:startPriority', function(bool,locations)
	currentPriority = bool
	print("Server received startPriority")
	TriggerClientEvent('mitchPriorities.currentPriority:OnDutyAlert', -1,locations)
	if bool then
		Wait((10000))
		currentPriority = false
	end
end)