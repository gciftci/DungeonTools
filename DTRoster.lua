-- Author      : Garbis
-- Create Date : 7/27/2018 6:01:41 PM
-- Roster

-- EventHandler
local events = {}
local eventHandler = CreateFrame("Frame")

-- @EVENT
-- PLAYER_ENTERING_WORLD
-- Fired when the player enters the world, enters/leaves an instance, or respawns at a graveyard. Also fires any other time the player sees a loading screen. 
function events:PLAYER_ENTERING_WORLD(...)
end

-- @EVENT
-- PLAYER_REGEN_DISABLED
-- Fired after ending combat
function events:PLAYER_REGEN_DISABLED(...)
	if DungeonTool.db.global.hideOnFight == "true" then
		DTFrmMain:Hide()
	end
end

-- @EVENT
-- PLAYER_REGEN_ENABLED
-- Fired after starting combat
function events:PLAYER_REGEN_ENABLED(...)
	if DungeonTool.db.global.hideOnFight == "true" and DungeonTool.db.global.frame.hide == false then
		DTFrmMain:Show()
	end
end

-- @EVENT -- GROUP_ROSTER_UPDATE --
function events:GROUP_ROSTER_UPDATE(...)
	-- TODO
	-- Instead of wiping the table every time remove accordingly? (does it matter with 5 values?)
	if DTFrmMain and DTFrmMain:IsVisible() == true then
        C_Timer.After(1, function() 
	        -- Clear table
			rosterTabClear(party_units)
			-- Update table
			rosterTabUpdate(party_units)
			-- Update Icon List
			rosterIconUpdate()
        end) 

	end
end


-- @EVENT
-- READY_CHECK
-- Fired when a Ready Check is performed by the raid (or party) leader. 
-- arg1: name of character requesting ready check (ie., "Ansu") 
-- arg2: variable number (usually 30). Denotes time before automatic check completion. 
function events:READY_CHECK(playerRequested, time)
	DTFrmMainIcon1:SetButtonState("normal", false)
	DTFrmMainIcon2:SetButtonState("normal", false)
	DTFrmMainIcon3:SetButtonState("normal", false)
	DTFrmMainIcon4:SetButtonState("normal", false)
	DTFrmMainIcon5:SetButtonState("normal", false)
	C_Timer.After(time, function() 
		DTFrmMainIcon1:SetButtonState("normal", true)
		DTFrmMainIcon2:SetButtonState("normal", true)
		DTFrmMainIcon3:SetButtonState("normal", true)
		DTFrmMainIcon4:SetButtonState("normal", true)
		DTFrmMainIcon5:SetButtonState("normal", true)
	end)
	-- changeTexture(objTex, objIcon, color, state)
	if DTFrmMain and DTFrmMain:IsVisible() then
		for i=1, #party_units do
			repeat
				if party_units[i].name == playerRequested then
					changeTexture(iconsTex[i], icons[i], "green", "normal")
				break
				end
			changeTexture(iconsTex[i], icons[i], "yellow", "normal")
			until true
		end
	end
	DTFrmMainstatusbar:Show()
	timer = tonumber(time)
        for i=0, timer do
            repeat
                if i == timer then
                    C_Timer.After(timer, function() 
                        DTFrmMainstatusbar:Hide()
                    end) 
                break
                end
                C_Timer.After(i, function() 
                    DTFrmMainstatusbar:SetMinMaxValues(0,timer)
                    DTFrmMainstatusbar:SetValue(tonumber(timer-i))
                end) 
            until true
        end
end

--@EVENT
-- READY_CHECK_CONFIRM
-- Fired when a player confirms ready status.
-- arg1: UnitID (raid1, party1). Fires twice if the confirming player is in your raid sub-group. 
-- arg2: status (1=ready, 0=not ready) 
function events:READY_CHECK_CONFIRM(player, status)
	if DTFrmMain and DTFrmMain:IsVisible() then
		for i=1, #party_units do
			repeat
				playerName = UnitName(player)
				if party_units[i].name == playerName then
					if status then
						changeTexture(iconsTex[i], icons[i], "green", "normal")
					else
						changeTexture(iconsTex[i], icons[i], "red", "normal")
				        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Not ready: " .. party_units[i].name .. "-" .. party_units[i].realm)
					end
				break
				end
			until true
		end
	end
end

--@EVENT
-- READY_CHECK_FINISHED
-- Fired when the ready check completes. 
function events:READY_CHECK_FINISHED(...)
	DTFrmMainstatusbar:Hide()
	C_Timer.After(10, function()
		changeTexture(DTFrmMainIcon1Ntex, DTFrmMainIcon1, "gray", "normal")
		changeTexture(DTFrmMainIcon2Ntex, DTFrmMainIcon2, "gray", "normal")
		changeTexture(DTFrmMainIcon3Ntex, DTFrmMainIcon3, "gray", "normal")
		changeTexture(DTFrmMainIcon4Ntex, DTFrmMainIcon4, "gray", "normal")
		changeTexture(DTFrmMainIcon5Ntex, DTFrmMainIcon5, "gray", "normal")
		DTFrmMainIcon1:SetButtonState("normal", true)
		DTFrmMainIcon2:SetButtonState("normal", true)
		DTFrmMainIcon3:SetButtonState("normal", true)
		DTFrmMainIcon4:SetButtonState("normal", true)
		DTFrmMainIcon5:SetButtonState("normal", true)
	 end)
end

-- Register Events
eventHandler:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...);
end);

for k, v in pairs(events) do
 eventHandler:RegisterEvent(k); -- Register all events for which handlers have been defined
end