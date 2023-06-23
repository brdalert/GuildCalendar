local em = GetEventManager()
local wm = GetWindowManager()
local _
GuildCalendar = {}
GuildCalendar.name = "GuildCalendar"

function GuildCalendar.Initialize()
  GuildCalendar.inCombat = IsUnitInCombat("player")
 
  EVENT_MANAGER:RegisterForEvent(GuildCalendar.name, EVENT_PLAYER_COMBAT_STATE, GuildCalendar.OnPlayerCombatState)
 
  GuildCalendar.savedVariables = ZO_SavedVars:NewCharacterIdSettings("GuildCalendarSavedVariables", 1, nil, {})
 
  GuildCalendar.RestorePosition()
end

function GuildCalendar.OnAddOnLoaded(event, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == GuildCalendar.name then
        GuildCalendar.Initialize()
      --unregister the event again as our addon was loaded now and we do not need it anymore to be run for each other addon that will load
      EVENT_MANAGER:UnregisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED) 
    end
end


function GuildCalendar.OnPlayerCombatState(event, inCombat)
  -- The ~= operator is "not equal to" in Lua.
  if inCombat ~= GuildCalendar.inCombat then
    -- The player's state has changed. Update the stored state...
    GuildCalendar.inCombat = inCombat
 
    -- ...and then update the control.
    GuildCalendarIndicator:SetHidden(not inCombat)
  end
end

function GuildCalendar.OnIndicatorMoveStop()
  GuildCalendar.savedVariables.left = GuildCalendarIndicator:GetLeft()
  GuildCalendar.savedVariables.top = GuildCalendarIndicator:GetTop()
end

function GuildCalendar.RestorePosition()
  local left = GuildCalendar.savedVariables.left
  local top = GuildCalendar.savedVariables.top
 
  GuildCalendarIndicator:ClearAnchors()
  GuildCalendarIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end
  
em:EVENT_MANAGER:RegisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED, GuildCalendar.OnAddOnLoaded)