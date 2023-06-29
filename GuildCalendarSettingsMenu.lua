local GuildCalendar = GuildCalendar
if GuildCalendar == nil then GuildCalendar = {} end
local _


-- init and check libs

 function GuildCalendar.MakeMenu(svdefaults)
    local menu = LibAddonMenu2
    if not LibAddonMenu2 then return end

    local db = GuildCalendar.db
    local def = svdefaults

    local panelData = {
        type = "panel",
        name = "Guild Calendar",
        displayName = "Guild Calendar",
        author = "@brdalert",
        version = "" .. GuildCalendar.version,
        registerForRefresh = true,
		registerForDefaults = true,
    }

    local options = {
        {
            type = "header",
            name = GetString(SI_GUILD_CALENDAR_MENU_PROFILES)
        },
        {
            type = "checkbox",
            name = GetString(SI_GUILD_CALENDAR_MENU_AC_NAME),
            tooltip = GetString(SI_GUILD_CALENDAR_MENU_AC_TOOLTIP),
            default = def.accountwide,
            getFunc = function() return SavedVars.Default[GetDisplayName()]['$AccountWide']["Settings"]["accountwide"] end,
            setFunc = function(value) SavedVars.Default[GetDisplayName()]['$AccountWide']["Settings"]["accountwide"] = value end,
            requiresReload = true,
        },
        {
            type = "custom",
        },
        {
            type = 'header',
            name = GetString(SI_GUILD_CALENDAR_MENU_GS_NAME),
        },
        {
            type = "checkbox",
            name = GetString(SI_GUILD_CALENDAR_MENU_LOCAL_TIME),
            tooltip = GetString(SI_GUILD_CALENDAR_MENU_LOCAL_TIME_TOOLTIP),
            default = def.localtime,
            getFunc = function() return db.localtime end,
            setFunc = function(value) db.localtime = value end,
        }
    }

    
    local panel = menu:RegisterAddonPanel("GuildCalendar_options", panelData)
    menu:RegisterOptionControls("GuildCalendar_options", options)

    function GuildCalendar.OpenSettings()

		menu:OpenToPanel(panel)

	end
 end
