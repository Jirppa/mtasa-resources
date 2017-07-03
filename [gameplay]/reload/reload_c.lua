local blockedTasks = 
{
	["TASK_SIMPLE_IN_AIR"] = true, -- We're falling or in a jump.
	["TASK_SIMPLE_JUMP"] = true, -- We're beginning a jump
	["TASK_SIMPLE_LAND"] = true, -- We're landing from a jump
	["TASK_SIMPLE_GO_TO_POINT"] = true, -- In MTA, this is the player probably walking to a car to enter it
	["TASK_SIMPLE_NAMED_ANIM"] = true, -- We're performing a setPedAnimation
	["TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE"] = true, -- Opening a car door
	["TASK_SIMPLE_CAR_GET_IN"] = true, -- Entering a car
	["TASK_SIMPLE_CLIMB"] = true, -- We're climbing or holding on to something
	["TASK_SIMPLE_SWIM"] = true,
	["TASK_SIMPLE_HIT_HEAD"] = true, -- When we try to jump but something hits us on the head
	["TASK_SIMPLE_FALL"] = true, -- We fell
	["TASK_SIMPLE_GET_UP"] = true -- We're getting up from a fall
}

local function reloadWeapon()

	local task = getPedSimplestTask (localPlayer) -- Usually, getting the simplest task is enough to suffice
	local slot = getPedWeaponSlot(localPlayer)
	
	if blockedTasks[task] then return end --If the player is performing any unwanted tasks, do not fire an event to reload
	if slot < 2 or slot > 5 then return end --If the player does not have a reloadable gun, do not fire an event to reload
	
	triggerLatentServerEvent("relWep",4000,false,resourceRoot) --Its really small event so use latent event instead to reduce traffic and CPU usage
	
end

-- The jump task is not instantly detectable and bindKey works quicker than getControlState
-- If you try to reload and jump at the same time, you will be able to instant reload.
-- We work around this by adding an unnoticable delay to foil this exploit.

local function reload()
	setTimer(reloadWeapon,50,1)
end

addCommandHandler("reload",reload,false)
bindKey("r","down","reload")
