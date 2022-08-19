local function generate_elements()
    local group = AceGUI:Create("SimpleGroup")
    group:SetFullWidth(true)
    group:SetLayout("List")

    local start_messages_edit_box = AceGUI:Create("EditBox")
    start_messages_edit_box:SetFullWidth(true)
    start_messages_edit_box:SetLabel("Start Messages (semicolon separated)")
    start_messages_edit_box:SetText(table.concat(NAMNAMVARS.start_messages, ";"))
    start_messages_edit_box:SetCallback("OnEnterPressed", function()
        NAMNAMVARS.start_messages = {}
        for message in string.gmatch(start_messages_edit_box:GetText(), "([^;]+)") do
            table.insert(NAMNAMVARS.start_messages, message)
        end
    end)

    local end_messages_edit_box = AceGUI:Create("EditBox")
    end_messages_edit_box:SetFullWidth(true)
    end_messages_edit_box:SetLabel("Start Messages (semicolon separated)")
    end_messages_edit_box:SetText(table.concat(NAMNAMVARS.end_messages, ";"))
    end_messages_edit_box:SetCallback("OnEnterPressed", function()
        NAMNAMVARS.end_messages = {}
        for message in string.gmatch(end_messages_edit_box:GetText(), "([^;]+)") do
            table.insert(NAMNAMVARS.end_messages, message)
        end
    end)

    local start_react_edit_box = AceGUI:Create("EditBox")
    start_react_edit_box:SetFullWidth(true)
    start_react_edit_box:SetLabel("Start Reply Message (NAME will get replaced)")
    start_react_edit_box:SetText(NAMNAMVARS.start_react)
    start_react_edit_box:SetCallback("OnEnterPressed", function()
        NAMNAMVARS.start_react = start_react_edit_box:GetText()
    end)

    local end_react_edit_box = AceGUI:Create("EditBox")
    end_react_edit_box:SetFullWidth(true)
    end_react_edit_box:SetLabel("End Reply Message (NAME will get replaced)")
    end_react_edit_box:SetText(NAMNAMVARS.end_react)
    end_react_edit_box:SetCallback("OnEnterPressed", function()
        NAMNAMVARS.end_react = end_react_edit_box:GetText()
    end)

    group:AddChild(start_messages_edit_box)
    group:AddChild(end_messages_edit_box)
    group:AddChild(start_react_edit_box)
    group:AddChild(end_react_edit_box)

    return group
end

local function ShowSettingsMenu()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("NamNamDetector Addon Settings")
    frame:SetStatusText("Click on the bottom right corner to resize this window.")
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    frame:SetLayout("Fill")

    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetFullWidth(true)
    scrollcontainer:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")

    frame:AddChild(scrollcontainer)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    scrollcontainer:AddChild(scroll)

    scroll:AddChild(generate_elements())
end

-- Add button to interface options which opens the settings
local frame = CreateFrame("Frame", event, InterfaceOptionsFramePanelContainer)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if (loadedAddon == addon_name) then
        local panel = CreateFrame("Frame", nil, UIParent)
        panel.name = "NamNamDetector"
        InterfaceOptions_AddCategory(panel)

        local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        button:SetPoint("CENTER", 0, 0)
        button:SetWidth(100)
        button:SetHeight(25)
        button:SetText("Open Settings")
        button:SetScript("OnClick", function()
            ShowSettingsMenu()
        end)
    end
end)

-- Show settings window on command
SLASH_NAMNAMDETECTOR1 = "/namnamdetector"
SLASH_NAMNAMDETECTOR2 = "/namnam"
SLASH_NAMNAMDETECTOR3 = "/nnd"
SlashCmdList["NAMNAMDETECTOR"] = function(msg)
    ShowSettingsMenu()
end
