
local em = GetEventManager()
local wm = GetWindowManager()
local _

-- Namespace for this addon
if GuildCalendar == nil then  GuildCalendar = {} end
local GuildCalendar = GuildCalendar

-- Basic values
GuildCalendar.name = "GuildCalendar"
GuildCalendar.version = "0.0.1"
GuildCalendar.variableVersion = 3

-- Default table for saved variables
GuildCalendar.Default = {
  offsetX = 0,
  offsetY = 0
}

GuildCalendar.Settings = {
  use_local_time = true,
}

-- Logger 
local mainlogger
local subloggers = {}
local LOG_LEVEL_VERBOSE = "V"
local LOG_LEVEL_DEBUG = "D"
local LOG_LEVEL_INFO = "I"
local LOG_LEVEL_WARNING ="W"
local LOG_LEVEL_ERROR = "E"

if LibDebugLogger then

	mainlogger = LibDebugLogger.Create(GuildCalendar.name)

	LOG_LEVEL_VERBOSE = LibDebugLogger.LOG_LEVEL_VERBOSE
	LOG_LEVEL_DEBUG = LibDebugLogger.LOG_LEVEL_DEBUG
	LOG_LEVEL_INFO = LibDebugLogger.LOG_LEVEL_INFO
	LOG_LEVEL_WARNING = LibDebugLogger.LOG_LEVEL_WARNING
	LOG_LEVEL_ERROR = LibDebugLogger.LOG_LEVEL_ERROR

  subloggers["main"] = mainlogger
  subloggers["UI"] = mainlogger:Create("UI")
end


local function Print(catagory, level, ...)
  if mainlogger == nil then return end

  local logger = category and subloggers[catagory] or mainlogger

  if type(logger.Log) =="function" then logger:Log(level, ...) end
end

GuildCalendar.Print = Print

function GuildCalendar.GetDebugLevels()

	return 	LOG_LEVEL_VERBOSE, LOG_LEVEL_DEBUG, LOG_LEVEL_INFO, LOG_LEVEL_WARNING, LOG_LEVEL_ERROR

end

-------------------------------------------------------------------------------------------------
--  Initialize Function --
-------------------------------------------------------------------------------------------------
function GuildCalendar.Initialize()
  GuildCalendar.savedVariables = ZO_SavedVars:NewAccountWide("SavedVars", GuildCalendar.variableVersion, "Default", GuildCalendar.Default, GetWorldName())
  
  GuildCalendar.savedVariables = ZO_SavedVars:NewAccountWide("SavedVars", GuildCalendar.variableVersion, "settings", GuildCalendar.Settings, GetWorldName())

  GuildCalendar.inCombat = IsUnitInCombat("player")
 
  GuildCalendar.RestorePosition()
  
  em:RegisterForEvent(GuildCalendar.name, EVENT_PLAYER_COMBAT_STATE, GuildCalendar.OnPlayerCombatState)
end

function GuildCalendar.OnAddOnLoaded(event, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == GuildCalendar.name then
        GuildCalendar.Initialize()
      --unregister the event again as our addon was loaded now and we do not need it anymore to be run for each other addon that will load
      em:UnregisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED) 
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
  GuildCalendar.savedVariables.offsetX = GuildCalendarIndicator:GetLeft()
  GuildCalendar.savedVariables.offsetY = GuildCalendarIndicator:GetTop()
end

function GuildCalendar.RestorePosition()
  local left = GuildCalendar.savedVariables.offsetX
  local top = GuildCalendar.savedVariables.offsetY

  GuildCalendarIndicator:ClearAnchors()
  GuildCalendarIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

-- register event handler function to initialize when addon is loaded
em:RegisterForEvent(GuildCalendar.name, EVENT_ADD_ON_LOADED, GuildCalendar.OnAddOnLoaded)