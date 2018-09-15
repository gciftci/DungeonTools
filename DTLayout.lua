-- Author      : Garbis
-- Create Date : 7/27/2018 5:56:43 PM
-- Layout

function DTCreateFrame()
	-- Main Frame
	DTFrmMain = CreateFrame("Frame", nil, UIParent)
	DTFrmMain:SetFrameStrata("BACKGROUND")
	DTFrmMain:SetWidth(335)
	DTFrmMain:SetHeight(110)
	DTFrmMain:SetMovable(true)
	DTFrmMain:EnableMouse(true)
	DTFrmMain:RegisterForDrag("LeftButton")
	DTFrmMain:SetScript("OnDragStart", DTFrmMain.StartMoving)
	DTFrmMain:SetScript("OnDragStop", function() 
	DTFrmMain:StopMovingOrSizing()
	DungeonTool.db.global.frame.point, DungeonTool.db.global.frame.relativeFrame, DungeonTool.db.global.frame.relativePoint, DungeonTool.db.global.frame.x, DungeonTool.db.global.frame.y = DTFrmMain:GetPoint()
	end)

	DTFrmMain:SetBackdrop( { 
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = false, tileSize = 0, edgeSize = 1,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});
	DTFrmMain:SetBackdropColor(0, 0, 0, 0.6)
	DTFrmMain:SetBackdropBorderColor(0,0,0,1)
	DTFrmMain:ClearAllPoints()
	DTFrmMain:SetPoint(
	DungeonTool.db.global.frame.point,
	DungeonTool.db.global.frame.relativeFrame,
	DungeonTool.db.global.frame.relativePoint,
	DungeonTool.db.global.frame.x,
	DungeonTool.db.global.frame.y
	)

	-- Title Bar
	local DTFrmMainTitle = CreateFrame("Frame",nil,DTFrmMain)
	DTFrmMainTitle:SetWidth(DTFrmMain:GetWidth())
	DTFrmMainTitle:SetHeight(25)
	DTFrmMainTitle:SetBackdrop( { 
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = true, tileSize = 32, edgeSize = 2,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});
	DTFrmMainTitle:SetBackdropColor(1, 1, 1, 0)
	DTFrmMainTitle:SetBackdropBorderColor(0,0,0,0)
	DTFrmMainTitle:SetPoint("TOP", DTFrmMain, 0,0)

	-- Title Bar Text
	DTFrmMainTitleText = DTFrmMainTitle:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	DTFrmMainTitleText:SetPoint("CENTER", DTFrmMainTitle, "CENTER", 0, 0)
	DTFrmMainTitleText:SetText("DungeonTools v0.01a")

	-- Statusbar
	DTFrmMainstatusbar = CreateFrame("StatusBar", nil, DTFrmMainTitle)
    DTFrmMainstatusbar:SetStatusBarTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainstatusbar:SetStatusBarColor(0,1,0,0.5)
    DTFrmMainstatusbar:SetHeight("23")
    DTFrmMainstatusbar:SetWidth("60")
    DTFrmMainstatusbar:SetPoint("TOPLEFT",8,-5)
    DTFrmMainstatusbar:SetOrientation("HORIZONTAL") 
    DTFrmMainstatusbar:SetMinMaxValues(0,100)
    DTFrmMainstatusbar:Hide()


	-- InFight Button
	DTFrmMainButtonFight = CreateFrame("Button", "DTFrmMainButtonFight", DTFrmMain)
	DTFrmMainButtonFight:SetSize(25,25)
	DTFrmMainButtonFight:SetPoint("TOPRIGHT", -30, 0)
	DTFrmMainButtonFight:RegisterForClicks("LeftButtonUp")
	DTFrmMainButtonFight:SetScript("OnClick", function(self, button,down) 
			if DungeonTool.db.global.hideOnFight == "false" then
				DTFrmMainButtonFightNtex:SetAlpha(0.2)
				DTFrmMainButtonFightHtex:SetAlpha(0.2)
				DTFrmMainButtonFightPtex:SetAlpha(0.2)
				DungeonTool.db.global.hideOnFight = "true"
				print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Automatically hide Window on fight: " .. DungeonTool.db.global.hideOnFight)
			else
				DTFrmMainButtonFightNtex:SetAlpha(1)
				DTFrmMainButtonFightHtex:SetAlpha(1)
				DTFrmMainButtonFightPtex:SetAlpha(1)
				DungeonTool.db.global.hideOnFight = "false"
				print("|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r Automatically hide Window on fight: " .. DungeonTool.db.global.hideOnFight)
			end
		end)
	DTFrmMainButtonFight:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
	    GameTooltip:SetText("Hide in Combat")
	    GameTooltip:AddLine("Currently: " .. DungeonTool.db.global.hideOnFight)
		GameTooltip:Show()
	end)
	DTFrmMainButtonFight:SetScript("OnLeave", function(self, motion)
		GameTooltip:Hide()
	end)

	DTFrmMainButtonFightNtex = DTFrmMainButtonFight:CreateTexture()
	DTFrmMainButtonFightNtex2 = DTFrmMainButtonFight:CreateTexture()
	DTFrmMainButtonFightHtex = DTFrmMainButtonFight:CreateTexture()
	DTFrmMainButtonFightPtex = DTFrmMainButtonFight:CreateTexture()
	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainButtonFightNtex, DTFrmMainButtonFight, "Interface\\Buttons\\UI-Checkbox-SwordCheck", "normal")
	DTFrmMainButtonFightNtex:SetTexCoord(0, 16/25, 0, 16/25)
	changeTexture(DTFrmMainButtonFightHtex, DTFrmMainButtonFight, "Interface\\Buttons\\UI-Checkbox-SwordCheck", "hover")
	DTFrmMainButtonFightHtex:SetTexCoord(0, 16/25, 0, 16/25)
	changeTexture(DTFrmMainButtonFightPtex, DTFrmMainButtonFight, "Interface\\Buttons\\UI-Checkbox-SwordCheck", "pushed")
	DTFrmMainButtonFightPtex:SetTexCoord(0, 16/25, 0, 16/25)

	if DungeonTool.db.global.hideOnFight == "true" and DTFrmMainButtonFightNtex:GetAlpha() > 0.3 then
		DTFrmMainButtonFightNtex:SetAlpha(0.2)
		DTFrmMainButtonFightHtex:SetAlpha(0.2)
		DTFrmMainButtonFightPtex:SetAlpha(0.2)
	elseif DungeonTool.db.global.hideOnFight == "false" and DTFrmMainButtonFightNtex:GetAlpha() < 0.3 then
		DTFrmMainButtonFightNtex:SetAlpha(1)
		DTFrmMainButtonFightHtex:SetAlpha(1)
		DTFrmMainButtonFightPtex:SetAlpha(1)
	end



	-- Close-Button
	local DTFrmMainButtonClose = CreateFrame("Button", "closeButton", DTFrmMain)
	DTFrmMainButtonClose:SetSize(25,25)
	DTFrmMainButtonClose:SetPoint("TOPRIGHT",0,0)
	DTFrmMainButtonClose:RegisterForClicks("LeftButtonUp")
	DTFrmMainButtonClose:SetScript("OnClick", function(self, button,down)
	DTFrmMain:Hide()
	DTFrmMain:SetParent(nil) 
	end)
	DTFrmMainButtonClose:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
	    GameTooltip:SetText("Close Window")
		GameTooltip:Show()
	end)
	DTFrmMainButtonClose:SetScript("OnLeave", function(self, motion)
		GameTooltip:Hide()
	end)

	DTFrmMainButtonCloseText = DTFrmMainButtonClose:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	DTFrmMainButtonCloseText:SetPoint("CENTER", DTFrmMainButtonClose, "CENTER", 0, 0)
	DTFrmMainButtonCloseText:SetText("X")
	DTFrmMainButtonCloseText:SetTextColor(1,1,1,1,1)

	local DTFrmMainButtonCloseNtex = DTFrmMainButtonClose:CreateTexture()
	DTFrmMainButtonCloseNtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonCloseNtex:SetColorTexture(0,0,0,0.5)
	DTFrmMainButtonCloseNtex:SetAllPoints()	
	DTFrmMainButtonClose:SetNormalTexture(DTFrmMainButtonCloseNtex)

	local DTFrmMainButtonCloseHtex = DTFrmMainButtonClose:CreateTexture()
	DTFrmMainButtonCloseHtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonCloseHtex:SetColorTexture(1,1,1,0.05)
	DTFrmMainButtonCloseHtex:SetAllPoints()
	--DTFrmMainButtonCloseHtex:SetInside()
	DTFrmMainButtonClose:SetHighlightTexture(DTFrmMainButtonCloseHtex)

	local DTFrmMainButtonClosePtex = DTFrmMainButtonClose:CreateTexture()
	DTFrmMainButtonClosePtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonClosePtex:SetColorTexture(1,1,1,0.1)
	DTFrmMainButtonClosePtex:SetAllPoints()
	--DTFrmMainButtonClosePtex:SetInside()
	DTFrmMainButtonClose:SetPushedTexture(DTFrmMainButtonClosePtex)

	-- Readycheck-Button
	local DTFrmMainButtonReadycheck = CreateFrame("Button", "rdyButton", DTFrmMain)
	DTFrmMainButtonReadycheck:SetSize(120,30)
	DTFrmMainButtonReadycheck:SetPoint("TOPLEFT",5, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainButtonReadycheck:RegisterForClicks("LeftButtonUp")
	DTFrmMainButtonReadycheck:SetScript("OnClick", function(self, button,down) fReadycheck() end)
	DTFrmMainButtonReadycheck:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
		if IsInGroup() == false then
		    GameTooltip:SetText("You're not in a Group.")
		else
		    if UnitIsGroupLeader("player") == false then
		        GameTooltip:AddLine("You're not the Leader.")
		    else
		        GameTooltip:AddLine("Click to perform a Readycheck.")
		    end
		end
		GameTooltip:Show()
	end)
	DTFrmMainButtonReadycheck:SetScript("OnLeave", function(self, motion)
		GameTooltip:Hide()
	end)

	DTFrmMainButtonReadycheckText = DTFrmMainButtonReadycheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	DTFrmMainButtonReadycheckText:SetPoint("CENTER", DTFrmMainButtonReadycheck, "CENTER", 0, 0)
	DTFrmMainButtonReadycheckText:SetText("Readycheck")
	DTFrmMainButtonReadycheckText:SetTextColor(1,1,1,1,1)

	local DTFrmMainButtonReadycheckNtex = DTFrmMainButtonReadycheck:CreateTexture()
	DTFrmMainButtonReadycheckNtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonReadycheckNtex:SetColorTexture(0,0,0,0.5)
	DTFrmMainButtonReadycheckNtex:SetAllPoints()	
	DTFrmMainButtonReadycheck:SetNormalTexture(DTFrmMainButtonReadycheckNtex)

	local DTFrmMainButtonReadycheckHtex = DTFrmMainButtonReadycheck:CreateTexture()
	DTFrmMainButtonReadycheckHtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonReadycheckHtex:SetColorTexture(1,1,1,0.05)
	DTFrmMainButtonReadycheckHtex:SetAllPoints()
	--DTFrmMainButtonReadycheckHtex:SetInside()
	DTFrmMainButtonReadycheck:SetHighlightTexture(DTFrmMainButtonReadycheckHtex)

	local DTFrmMainButtonReadycheckPtex = DTFrmMainButtonReadycheck:CreateTexture()
	DTFrmMainButtonReadycheckPtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonReadycheckPtex:SetColorTexture(1,1,1,0.1)
	DTFrmMainButtonReadycheckPtex:SetAllPoints()
	--DTFrmMainButtonReadycheckPtex:SetInside()
	DTFrmMainButtonReadycheck:SetPushedTexture(DTFrmMainButtonReadycheckPtex)

	-- Icon and IconTexture-Table (Obj)
	icons = {}
	iconsTex = {}

	-- Icon 0-Button
	DTFrmMainIcon1 = CreateFrame("Button", "DTFrmMainIcon1", DTFrmMain)
	icons[1] = DTFrmMainIcon1
	DTFrmMainIcon1:SetButtonState("normal", true)
	DTFrmMainIcon1:SetSize(30,30)
	DTFrmMainIcon1:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 10, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainIcon1:RegisterForClicks("LeftButtonUp")
	DTFrmMainIcon1:SetScript("OnClick", function(self, button,down)
		if IsInGroup() then
			SendChatMessage("[DTools] " .. party_units[1].name .. ", ready?", "PARTY")
		end
	end)
	DTFrmMainIcon1:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
		GameTooltip:SetText(party_units[1].name)
		GameTooltip:AddLine(party_units[1].realm)
		GameTooltip:Show()
		end)
	DTFrmMainIcon1:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	DTFrmMainIcon1Ntex = DTFrmMainIcon1:CreateTexture()
	DTFrmMainIcon1Htex = DTFrmMainIcon1:CreateTexture()
	DTFrmMainIcon1Ptex = DTFrmMainIcon1:CreateTexture()
	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainIcon1Ntex, DTFrmMainIcon1, "gray", "normal")
	changeTexture(DTFrmMainIcon1Htex, DTFrmMainIcon1, "gray", "hover")
	changeTexture(DTFrmMainIcon1Ptex, DTFrmMainIcon1, "gray", "pushed")

	iconsTex[1] = DTFrmMainIcon1Ntex

	-- Icon 1-Button
	DTFrmMainIcon2 = CreateFrame("Button", "DTFrmMainIcon2", DTFrmMain)
	icons[2] = DTFrmMainIcon2
	DTFrmMainIcon2:SetButtonState("normal", true)
	DTFrmMainIcon2:SetSize(30,30)
	DTFrmMainIcon2:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 45, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainIcon2:RegisterForClicks("LeftButtonUp")
	DTFrmMainIcon2:SetScript("OnClick", function(self, button,down)
		if IsInGroup() then
			SendChatMessage("[DTools] " .. party_units[2].name .. ", ready?", "PARTY")
		end
	end)
	DTFrmMainIcon2:SetScript("OnEnter", function(self, motion)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			GameTooltip:SetText(party_units[2].name)
			GameTooltip:AddLine(party_units[2].realm)
			GameTooltip:Show()
		end)
	DTFrmMainIcon2:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	DTFrmMainIcon2Ntex = DTFrmMainIcon2:CreateTexture()
	DTFrmMainIcon2Htex = DTFrmMainIcon2:CreateTexture()
	DTFrmMainIcon2Ptex = DTFrmMainIcon2:CreateTexture()

	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainIcon2Ntex, DTFrmMainIcon2, "gray", "normal")
	changeTexture(DTFrmMainIcon2Htex, DTFrmMainIcon2, "gray", "hover")
	changeTexture(DTFrmMainIcon2Ptex, DTFrmMainIcon2, "gray", "pushed")

	iconsTex[2] = DTFrmMainIcon2Ntex

	-- Icon 2-Button
	DTFrmMainIcon3 = CreateFrame("Button", "DTFrmMainIcon3", DTFrmMain)
	icons[3] = DTFrmMainIcon3
	DTFrmMainIcon3:SetButtonState("normal", true)
	DTFrmMainIcon3:SetSize(30,30)
	DTFrmMainIcon3:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 80, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainIcon3:RegisterForClicks("LeftButtonUp")
	DTFrmMainIcon3:SetScript("OnClick", function(self, button,down)
		if IsInGroup() then
			SendChatMessage("[DTools] " .. party_units[3].name .. ", ready?", "PARTY")
		end
	end)
	DTFrmMainIcon3:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
		GameTooltip:SetText(party_units[3].name)
		GameTooltip:AddLine(party_units[3].realm)
		GameTooltip:Show()
		end)
	DTFrmMainIcon3:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	DTFrmMainIcon3Ntex = DTFrmMainIcon3:CreateTexture()
	DTFrmMainIcon3Htex = DTFrmMainIcon3:CreateTexture()
	DTFrmMainIcon3Ptex = DTFrmMainIcon3:CreateTexture()

	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainIcon3Ntex, DTFrmMainIcon3, "gray", "normal")
	changeTexture(DTFrmMainIcon3Htex, DTFrmMainIcon3, "gray", "hover")
	changeTexture(DTFrmMainIcon3Ptex, DTFrmMainIcon3, "gray", "pushed")

	iconsTex[3] = DTFrmMainIcon3Ntex

	-- Icon 3-Button
	DTFrmMainIcon4 = CreateFrame("Button", "DTFrmMainIcon4", DTFrmMain)
	icons[4] = DTFrmMainIcon4
	DTFrmMainIcon4:SetButtonState("normal", true)
	DTFrmMainIcon4:SetSize(30,30)
	DTFrmMainIcon4:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 115, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainIcon4:RegisterForClicks("LeftButtonUp")
	DTFrmMainIcon4:SetScript("OnClick", function(self, button,down)
		if IsInGroup() then
			SendChatMessage("[DTools] " .. party_units[4].name .. ", ready?", "PARTY")
		end
	end)
	DTFrmMainIcon4:SetScript("OnEnter", function(self, motion)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			GameTooltip:SetText(party_units[4].name)
			GameTooltip:AddLine(party_units[4].realm)
			GameTooltip:Show()
		end)
	DTFrmMainIcon4:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	DTFrmMainIcon4Ntex = DTFrmMainIcon4:CreateTexture()
	DTFrmMainIcon4Htex = DTFrmMainIcon4:CreateTexture()
	DTFrmMainIcon4Ptex = DTFrmMainIcon4:CreateTexture()

	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainIcon4Ntex, DTFrmMainIcon4, "gray", "normal")
	changeTexture(DTFrmMainIcon4Htex, DTFrmMainIcon4, "gray", "hover")
	changeTexture(DTFrmMainIcon4Ptex, DTFrmMainIcon4, "gray", "pushed")

	iconsTex[4] = DTFrmMainIcon4Ntex

	-- Icon 4-Button
	DTFrmMainIcon5 = CreateFrame("Button", "DTFrmMainIcon5", DTFrmMain)
	icons[5] = DTFrmMainIcon5
	DTFrmMainIcon5:SetButtonState("normal", true)
	DTFrmMainIcon5:SetSize(30,30)
	DTFrmMainIcon5:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 150, -DTFrmMainTitle:GetHeight() -5)
	DTFrmMainIcon5:RegisterForClicks("LeftButtonUp")
	DTFrmMainIcon5:SetScript("OnClick", function(self, button,down)
		if IsInGroup() then
			SendChatMessage("[DTools] " .. party_units[5].name .. ", ready?", "PARTY")
		end
	end)
	DTFrmMainIcon5:SetScript("OnEnter", function(self, motion)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			GameTooltip:SetText(party_units[5].name)
			GameTooltip:AddLine(party_units[5].realm)
			GameTooltip:Show()
		end)
	DTFrmMainIcon5:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	DTFrmMainIcon5Ntex = DTFrmMainIcon5:CreateTexture()
	DTFrmMainIcon5Htex = DTFrmMainIcon5:CreateTexture()
	DTFrmMainIcon5Ptex = DTFrmMainIcon5:CreateTexture()

	-- changeTexture(objTex, objIcon, "color", "state")
	changeTexture(DTFrmMainIcon5Ntex, DTFrmMainIcon5, "gray", "normal")
	changeTexture(DTFrmMainIcon5Htex, DTFrmMainIcon5, "gray", "hover")
	changeTexture(DTFrmMainIcon5Ptex, DTFrmMainIcon5, "gray", "pushed")

	iconsTex[5] = DTFrmMainIcon5Ntex
	
	-- Pulltimer-EditBox
	DTFrmMainEditPulltimer = CreateFrame("EditBox", "Pulltimer-EditBox", DTFrmMain, "InputBoxTemplate")
	DTFrmMainEditPulltimer:SetAutoFocus(false)
	DTFrmMainEditPulltimer:SetFontObject(ChatFontNormal)
	DTFrmMainEditPulltimer:SetWidth(60)
	DTFrmMainEditPulltimer:SetHeight(30)
	DTFrmMainEditPulltimer:SetMaxLetters(2)
	DTFrmMainEditPulltimer:SetPoint("TOPLEFT",5 + DTFrmMainButtonReadycheck:GetWidth() + 10, -DTFrmMainTitle:GetHeight() - DTFrmMainButtonReadycheck:GetHeight() -10)
	DTFrmMainEditPulltimer:SetScript("OnEditFocusLost", OnFocusLost)
	DTFrmMainEditPulltimer:SetScript("OnEditFocusGained", OnFocusGained)

	-- Pulltimer-Button
	DTFrmMainButtonPulltimer = CreateFrame("Button", "Pulltimer-Button", DTFrmMain)
	DTFrmMainButtonPulltimer:SetSize(120,30)
	DTFrmMainButtonPulltimer:SetPoint("TOPLEFT",5, -DTFrmMainTitle:GetHeight() - DTFrmMainButtonReadycheck:GetHeight() -10)
	DTFrmMainButtonPulltimer:RegisterForClicks("LeftButtonUp")
	DTFrmMainButtonPulltimer:SetScript("OnClick", function(self, button,down) fPulltimer() end)
	DTFrmMainButtonPulltimer:SetScript("OnEnter", function(self, motion)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
		if IsInGroup() == false then
		    GameTooltip:SetText("You're not in a Group.")
		else
		    if UnitIsGroupLeader("player") == false then
		        GameTooltip:AddLine("You're not the Leader.")
		    else
		        GameTooltip:AddLine("Click to start a pulltimer.")
		    end
		end
		GameTooltip:Show()
	end)
	DTFrmMainButtonPulltimer:SetScript("OnLeave", function(self, motion)
		GameTooltip:Hide()
	end)

	DTFrmMainButtonPulltimerText = DTFrmMainButtonPulltimer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	DTFrmMainButtonPulltimerText:SetPoint("CENTER", DTFrmMainButtonPulltimer, "CENTER", 0, 0)
	DTFrmMainButtonPulltimerText:SetText("Pulltimer: " .. DungeonTool.db.global.pulltimer .. "s")
	DTFrmMainButtonPulltimerText:SetTextColor(1,1,1,1,1)

	local DTFrmMainButtonPulltimerNtex = DTFrmMainButtonPulltimer:CreateTexture()
	DTFrmMainButtonPulltimerNtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonPulltimerNtex:SetColorTexture(0,0,0,0.5)
	DTFrmMainButtonPulltimerNtex:SetAllPoints()	
	DTFrmMainButtonPulltimer:SetNormalTexture(DTFrmMainButtonPulltimerNtex)

	local DTFrmMainButtonPulltimerHtex = DTFrmMainButtonPulltimer:CreateTexture()
	DTFrmMainButtonPulltimerHtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonPulltimerHtex:SetColorTexture(1,1,1,0.05)
	DTFrmMainButtonPulltimerHtex:SetAllPoints()
	--DTFrmMainButtonPulltimerHtex:SetInside()
	DTFrmMainButtonPulltimer:SetHighlightTexture(DTFrmMainButtonPulltimerHtex)

	local DTFrmMainButtonPulltimerPtex = DTFrmMainButtonPulltimer:CreateTexture()
	DTFrmMainButtonPulltimerPtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainButtonPulltimerPtex:SetColorTexture(1,1,1,0.1)
	DTFrmMainButtonPulltimerPtex:SetAllPoints()
	--DTFrmMainButtonPulltimerPtex:SetInside()
	DTFrmMainButtonPulltimer:SetPushedTexture(DTFrmMainButtonPulltimerPtex)

	-- Pulltimer-EditBox OK Button
	DTFrmMainEditPulltimerOK = CreateFrame("Button", "OK-Button", DTFrmMain)
	DTFrmMainEditPulltimerOK:SetSize(40,30)
	DTFrmMainEditPulltimerOK:SetPoint("TOPLEFT",5 + DTFrmMainButtonPulltimer:GetWidth() + 5 + DTFrmMainEditPulltimer:GetWidth() + 5, -DTFrmMainTitle:GetHeight() - 5 - DTFrmMainButtonReadycheck:GetHeight() -5)

	DTFrmMainEditPulltimerOKText = DTFrmMainEditPulltimerOK:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	DTFrmMainEditPulltimerOKText:SetPoint("CENTER", DTFrmMainEditPulltimerOK, "CENTER", 0, 0)
	DTFrmMainEditPulltimerOKText:SetText("OK")
	DTFrmMainEditPulltimerOKText:SetTextColor(1,1,1,1,1)

	DTFrmMainEditPulltimerOK:SetScript("OnClick", function()
		if tonumber(DTFrmMainEditPulltimer:GetText()) ~= nil then
			DungeonTool.db.global.pulltimer = tonumber(DTFrmMainEditPulltimer:GetText())
			DTFrmMainButtonPulltimerText:SetText("Pulltimer: " .. DungeonTool.db.global.pulltimer .. "s")
		else
			print('|cFF00FFFF[|cFF006565D|cFFFFFF00Tools|cFF00FFFF]|r "' .. DTFrmMainEditPulltimer:GetText() .. '" is not a number!')
			DTFrmMainEditPulltimer:SetText(DungeonTool.db.global.pulltimer)
		end
	DTFrmMainEditPulltimer:ClearFocus()
	end)
	DTFrmMainEditPulltimerOK:Hide()

	local DTFrmMainEditPulltimerOKNtex = DTFrmMainEditPulltimerOK:CreateTexture()
	DTFrmMainEditPulltimerOKNtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainEditPulltimerOKNtex:SetColorTexture(0,0,0,0.5)
	DTFrmMainEditPulltimerOKNtex:SetAllPoints()	
	DTFrmMainEditPulltimerOK:SetNormalTexture(DTFrmMainEditPulltimerOKNtex)

	local DTFrmMainEditPulltimerOKHtex = DTFrmMainEditPulltimerOK:CreateTexture()
	DTFrmMainEditPulltimerOKHtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainEditPulltimerOKHtex:SetColorTexture(1,1,1,0.05)
	DTFrmMainEditPulltimerOKHtex:SetAllPoints()
	--DTFrmMainEditPulltimerOKHtex:SetInside()
	DTFrmMainEditPulltimerOK:SetHighlightTexture(DTFrmMainEditPulltimerOKHtex)

	local DTFrmMainEditPulltimerOKPtex = DTFrmMainEditPulltimerOK:CreateTexture()
	DTFrmMainEditPulltimerOKPtex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	DTFrmMainEditPulltimerOKPtex:SetColorTexture(1,1,1,0.1)
	DTFrmMainEditPulltimerOKPtex:SetAllPoints()
	--DTFrmMainEditPulltimerOKPtex:SetInside()
	DTFrmMainEditPulltimerOK:SetPushedTexture(DTFrmMainEditPulltimerOKPtex)

	DTFrmMainEditPulltimerOK:SetPoint("TOPLEFT",DTFrmMainButtonReadycheck:GetWidth() + 10 + DTFrmMainEditPulltimer:GetWidth() + 5, -DTFrmMainTitle:GetHeight() - DTFrmMainButtonReadycheck:GetHeight() -10)
	DTFrmMainEditPulltimerOK:Hide()		

	-- Show Main Frame
	DTFrmMain:Show()
end