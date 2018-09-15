-- Author      : Garbis
-- Create Date : 7/27/2018 5:56:43 PM
-- Core

DungeonTool = LibStub("AceAddon-3.0"):NewAddon("DungeonTool", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");
AceGUI = LibStub("AceGUI-3.0")

-- Create Default-DB
local defaults = {
    global = {
        pulltimer = "6",
        LDBIconStorage = {},
        frame = {
            hide = false,
            point = "RIGHT",
            relativeFrame = nil,
            relativePoint = "CENTER",
            x = "0",
            y = "0",
        },
        icon = {
            hide = false,
        },
        debug = false,
        hideOnFight = "false",
    }}

-- Unit Tables + Player (Always visible, obviously)
party_units = {}

-- Create DB
DTIcon = LibStub("LibDBIcon-1.0")
local DTLDBObject = LibStub("LibDataBroker-1.1"):NewDataObject("DTLDBObjectNew", {
    type = "data source",
    text = "DTLDBObjectNew",
    icon = "Interface\\Icons\\INV_Hammer_18",
    OnClick = function(self, button)
        if button == "LeftButton" then
            DungeonTool.db.global.icon.hide = true
            DTIcon:Hide("DTLDBObjectNew")
        elseif button == "RightButton" then
            DTFrmMainVisible()
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("|cFFff4040Left Click|r closes Minimap-Button.\n|cFFff4040Right Click|r show/hides Frame.", 0.2, 1, 0.2)
        tooltip:AddLine("or use /dt for showing/hiding Minimap-Button.", 1, 1, 1)
    end,
})
    
--
-- Called when the addon is initialized
--
function DungeonTool:OnInitialize()
    -- Add some Chat-Commands
    SlashCmdList["DUNGEONTOOLS"] = DTSlashHandler;
    SLASH_DUNGEONTOOLS1 = "/dungeontools";
    SLASH_DUNGEONTOOLS2 = "/dt";
    
    -- Welcome message
    print("|cFF00FFFF[|cFF006565Dungeon|cFFFFFF00Tools|cFF00FFFF]|r v1.0 loaded.")
    
    -- initialize DB
    self.db = LibStub("AceDB-3.0"):New("DTDB", defaults, true)

    -- Show Frame
    playerName, playerRealm = UnitName("player")
    if playerRealm == nil or playerRealm == "" then
        playerRealm = "*"
    end
    table.insert(party_units, { name = playerName, realm = playerRealm})
    DTCreateFrame()
    if self.db.global.frame.hide == true then
        DTFrmMain:Hide()
    end
    -- Clear table
    rosterTabClear(party_units)
    -- Update table
    rosterTabUpdate(party_units)
    -- Update Icon List
    rosterIconUpdate()
end

--
-- Called when the addon is loaded
--
function DungeonTool:OnEnable()
    -- Show Icon
    if DTIcon then
        DTIcon:Register("DTLDBObjectNew", DTLDBObject, DungeonTool.db.global.LDBIconStorage)
        if self.db.global.icon.hide == false then
            C_Timer.After(1, function() DTIcon:Show("DTLDBObjectNew") end)
        else
            C_Timer.After(1, function() DTIcon:Hide("DTLDBObjectNew") end)
        end
    end
    -- Update Icon List
   C_Timer.After(3, function() rosterIconUpdate() end)
end

--
-- Called when the addon is disabled
--
function DungeonTool:OnDisable()
    
end