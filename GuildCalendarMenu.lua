local GuildCalendar = GuildCalendar
if GuildCalendar == nil then GuildCalendar = {} end
local _

-- init and check libs
local LAM = LibAddonMenu2
if LAM == nil then
    GuildCalendar.Print("main", LOG_LEVEL_ERROR, "LibAddonMenu2 not found")
    return
end