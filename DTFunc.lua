-- Author      : Gkane
-- Create Date : 7/27/2018 5:49:26 PM
-- Functions


-- Function: Change Texture
-- @objTex: name of the Tex-object object that should change.
-- @color: colors[gray/yellow/green/red] or custom texture "\\interface\\blah"
-- @state: 1: normal, 2: hover, 3: pushed
-- @objIcon: name of the Icon object 
function changeTexture(objTex, objIcon, color, state)
    local colors = {
        gray = "Interface\\COMMON\\Indicator-Gray",
        yellow = "Interface\\COMMON\\Indicator-Yellow",
        green = "Interface\\COMMON\\Indicator-Green",
        red = "Interface\\COMMON\\Indicator-Red"
    }

    if colors[color] == nil then
        texture = color
    else
        texture = colors[color]
    end

    if objTex and objIcon then
    	if state == "normal" then
    		objTex:SetTexture(texture)
    		objTex:SetAllPoints()
    		--objTex:SetInside()
    		objIcon:SetNormalTexture(objTex)
    	elseif state == "hover" then
    		objTex:SetTexture(texture)
    		objTex:SetAllPoints()
    		--objTex:SetInside()
    		objIcon:SetHighlightTexture(objTex)
    	elseif state == "pushed" then
    		objTex:SetTexture(texture)
    		objTex:SetAllPoints()
    		objIcon:SetPushedTexture(objTex)	
    	end
    end
end

-- Function: Wipe a table.
-- @tbl: name of the table to be cleared
function rosterTabClear(tbl)
    for k in pairs(tbl) do
        party_units[k] = nil
    end
end

-- Function: Insert unit to a table.
-- @tbl: name of the table to add to
-- @unit: unit to add to table
function rosterAddUnit(tbl, unit)
    table.insert(tbl, unit)
end

-- Function: Update a unit table.
-- @
function rosterTabUpdate(tbl)
    if IsInRaid() == false then
        for i=1, GetNumSubgroupMembers() + 1 do
         repeat
           if i == 1 then
            playerName, playerRealm = UnitName("player")
                if playerRealm == nil or playerRealm == "" then
                    playerRealm = "*"
                end
            rosterAddUnit(tbl, { name = playerName, realm = playerRealm })
            break
           end
            s = i-1
            n = ("party%d"):format(s)
            playerName, playerRealm = UnitName(n)
            if playerRealm == nil or playerRealm == "" then
                    playerRealm = "*"
            end
            rosterAddUnit(tbl, { name = playerName, realm = playerRealm })
         until true
        end
    end
end


-- Function: Update Roster-Icons
-- @
function rosterIconUpdate()
    -- Hide All
    for i=1, 5 do
     icons[i]:Hide()
    end

    -- Show according to party_units
    for k in pairs(party_units) do
        icons[k]:Show()
    end    
end

-- Function: Perform Readycheck
-- @
function fReadycheck()
    if IsInGroup() == false then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Not in a Group.")
    else
        if UnitIsGroupLeader("player") == false then
            print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r You're not the leader.")
        else
            print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Starting a Readycheck!")
            DoReadyCheck()
        end
    end
end


-- Function: Perform Pulltimer
-- @
function fPulltimer()
    if IsInGroup() == true then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Pulling in: " .. DungeonTool.db.global.pulltimer .. "s")
        timer = tonumber(DungeonTool.db.global.pulltimer)
        for i=0, timer do
            repeat
                if i == timer then
                    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) == true then
                        C_Timer.After(timer, function() 
                            SendChatMessage("[DTools] Pulling!" ,"INSTANCE_CHAT")
                        end)
                    else
                        C_Timer.After(timer, function() 
                            SendChatMessage("[DTools] Pulling!" ,"PARTY")
                        end)
                    end
                break
                end
                    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) == true then
                        C_Timer.After(i, function() 
                            local ct = date("*t").hour .. ":" .. date("*t").min .. ":" .. date("*t").sec
                            SendChatMessage("[DTools] Pull in: " ..  DungeonTool.db.global.pulltimer-i,"INSTANCE_CHAT")
                        end) 
                    else
                        C_Timer.After(i, function() 
                            local ct = date("*t").hour .. ":" .. date("*t").min .. ":" .. date("*t").sec
                            SendChatMessage("[DTools] Pull in: " ..  DungeonTool.db.global.pulltimer-i,"PARTY")
                        end) 
                    end
            until true
        end
    else 
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Not in a Group.")
    end
end

-- Function: DTMenu
-- @
function DungeonTool:DTMenu()
    if DTMinimapHide then
        DTIcon:Show("DTLDBObjectNew")
        DungeonTool.global.frame.hide = false
    else
        DTIcon:Hide("DTLDBObjectNew")
        DungeonTool.global.frame.hide = true
    end
end

-- Function: Check Visibility Main Frame, turn on/off (Minimap Click)
-- @
function DTFrmMainVisible()
    if DTFrmMain:IsVisible() then
        DTFrmMain:Hide()
        DungeonTool.db.global.frame.hide = true
    else
        DTFrmMain:Show()
        DungeonTool.db.global.frame.hide = false
    end
end
-- Function: Refresh DB
-- @
function updateDB(self, event, database)
    db = database.profile;
    LibStub("LibDBIcon-1.0"):Refresh("AddonLDBObjectName", self.db.global.LDBIconStorage);
end

-- Function: SlashHandler
-- @
function DTSlashHandler(msg)
    
    local _, _, command, options = string.find(msg, "([%w%p]+)%s*(.*)$");

    if (command) then
        command = string.lower(command);
    end
    if command == nil or command == "" then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Available Commands:")
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r /dt toggle |cFFAFAFAFToggles visibility of DungeonTool frame.")
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r /dt minimap |cFFAFAFAFShows Minimap Icon.")
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r /dt save |cFFAFAFAFSaves the current location of the DungeonTool frame.")
        
    elseif command == 'minimap' then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Showing icon.")
        DTIcon:Show("DTLDBObjectNew")
        DungeonTool.db.global.icon.hide = false
        
    elseif command == 'toggle' then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Toggling visibility.")
        DTFrmMainVisible()
        
    elseif command == 'save' then
        print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Saving location of DungeonTool frame.")
        DungeonTool.db.global.frame.point, DungeonTool.db.global.frame.relativeFrame, DungeonTool.db.global.frame.relativePoint, DungeonTool.db.global.frame.x, DungeonTool.db.global.frame.y = DTFrmMain:GetPoint()
    end
    
end

-- Function: Debug
-- @
function DTDebug(msg, timer)
    if DungeonTool.db.global.debug ~= true then
        return
    end
    
    local ct = date("*t").hour .. ":" .. date("*t").min .. ":" .. date("*t").sec
    if timer then
        print("[" .. ct .. "] " .. msg)
    else
        print(msg)
    end
end

-- Function: Editbox - On Focus Gained
-- @
function OnFocusGained(self)
    DTFrmMainEditPulltimerOK:Show()
end

-- Function: Editbox - On Focus Lost
-- @
function OnFocusLost(self)
    DTFrmMainEditPulltimerOK:Hide()
end
