local strings = {

-- Colors

    SI_GUILD_CALENDAR_SEP_COLOR = "FFAAAAAA",
    SI_GUILD_CALENDAR_HEALTH_COLOR = "FFDE6531",
    SI_GUILD_CALENDAR_MAGICKA_COLOR = "FF5EBDE7",
    SI_GUILD_CALENDAR_STAMINA_COLOR = "FFA6D852",
    SI_GUILD_CALENDAR_ULTIMATE_COLOR = "FFffe785",

-- Funtionality
    SI_COMBAT_METRICS_LANG = "en",

-- Settings Menu

    SI_GUILD_CALENDAR_MENU_PROFILES = "Profiles",

    SI_GUILD_CALENDAR_MENU_AC_NAME = "Use accountwide settings",
    SI_GUILD_CALENDAR_MENU_AC_TOOLTIP = "If enabled all chars of an account will share use these settings. The default is True",

    SI_GUILD_CALENDAR_MENU_GS_NAME = "General Settings",

    SI_GUILD_CALENDAR_MENU_LOCAL_TIME = "Use Local Time",
    SI_GUILD_CALENDAR_MENU_LOCAL_TIME_TOOLTIP = "If enabled Guild Calendart will use your local time. Otherwise it will server time. the default is True",


}


-- Localization End

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end