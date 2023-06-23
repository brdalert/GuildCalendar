local GuildCalendar = GuildCalendar
if GuildCalendar == nil then GuildCalendar = {} end
local _


-- init and check libs
local LAM = LibAddonMenu2
if LAM == nil then
    GuildCalendar.Print("main", LOG_LEVEL_ERROR, "LibAddonMenu2 not found")
    return
end

local LAM = LibAddonMenu2

local panelName = "GuildCalendarSettings" -- TODO the name will be used to create a global variable, pick something unique or you may overwrite an existing variable!
 
local panelData = {
    type = "panel",
    name = "Guild Calendar",
    author = "me",
}
local panel = LAM:RegisterAddonPanel(panelName, panelData)
local optionsData = {
    [1] = {
        type="header",
        name = "Time and Date Settings"
    },

    [2] = {
        type = "checkbox",
        name = "Display calendar events in local time",
        tooltip = "When on the calendar will use yor local. otherwise it will use the server time",
        getFunc = function() return GuildCalendar.savedVariables.use_local_time end,
        setFunc = function(value) GuildCalendar.savedVariables.use_local_time = value end,
        default = true
    }
    
}

LAM:RegisterOptionControls(panelName, optionsData)