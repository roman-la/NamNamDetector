-- Setup global variables
addon_name = ...

-- Execute code after variables are loaded (all addons are loaded at this point)
local addon_loaded_frame = CreateFrame("FRAME")
addon_loaded_frame:RegisterEvent("ADDON_LOADED")
addon_loaded_frame:SetScript("OnEvent", function(self, event, loaded_addon)
    -- Wrong addon
    if loaded_addon ~= addon_name then
        return
    end

    -- Setup vars if addon is first time used
    if type(NAMNAMVARS) ~= "table" then
        NAMNAMVARS = {}
    end

    if NAMNAMVARS.start_messages == nil then
        NAMNAMVARS.start_messages = {"eating nam nam"}
    end

    if NAMNAMVARS.end_messages == nil then
        NAMNAMVARS.end_messages = {"nam nam done", "nam nam done :)"}
    end

    if NAMNAMVARS.start_react == nil then
        NAMNAMVARS.start_react = "NamNamDetector: NAME started eating."
    end

    if NAMNAMVARS.end_react == nil then
        NAMNAMVARS.end_react = "NamNamDetector: NAME finished eating."
    end
end)

local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_SAY")
frame:SetScript("OnEvent", function(self, event, ...)
    local text, sender = ...

    for i, message in pairs(NAMNAMVARS.start_messages) do
        if text == message then
            SendChatMessage(NAMNAMVARS.start_react:gsub("%NAME", sender), "say")
            return
        end
    end

    for i, message in pairs(NAMNAMVARS.end_messages) do
        if text == message then
            SendChatMessage(NAMNAMVARS.end_react:gsub("%NAME", sender), "say")
            return
        end
    end
end)

