local em = GetEventManager()
local wm = GetWindowManager()
local _
GuildCalendar = {}
GuildCalendar.name = "GuildCalendar"
function guild_calendar.Inialize()
    
end

function GuildCalendar.OnAddOnLoaded(event, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == GuildCalendar.name then
        GuildCalendar.Initialize()
      --unregister the event again as our addon was loaded now and we do not need it anymore to be run for each other addon that will load
      EVENT_MANAGER:UnregisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED) 
    end
end

  EVENT_MANAGER:RegisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED, GuildCalendar.OnAddOnLoaded)