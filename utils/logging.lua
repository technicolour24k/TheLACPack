-- local helpers = gFunc.LoadFile("helpers.lua")

--[[
    Various logging options
]]--

tlp = tlp or {}
tlp.logging = tlp.logging or {}

-------------------------------------------------------------------------------
-- tlp.logging.info
-- @param msg string The Message you want to display. This will be prefixed with "[Info]"
-- @param col number The number assignment for the colour you want to display. Use tlp.utils.colourTest() to display all colours up to 255
--
-- Example usage:
-- tlp.logging.info("Ready to kick Shadow Lords butt!", 5) -- Displays "[Info] Ready to kick Shadow Lords butt!" in colour 5.
-- tlp.logging.info("Default colour message") -- Displays "[Info] Default colour message" in colour 2.
-------------------------------------------------------------------------------
tlp.logging.info = function(msg,col)
    -- Check if col is numeric
    if col and not tonumber(col) then
        tlp.logging.error("Colour value must be a number. Defaulting to colour 2.")
        col = 2 -- Default to a safe value
    end

    local colour = col or 2
    gFunc.Echo(colour, "[Info] "..msg)
end

-------------------------------------------------------------------------------
-- tlp.logging.error
-- @param msg string The Message you want to display. This will be prefixed with "[Error]"
-- @param col number The number assignment for the colour you want to display. Use tlp.utils.colourTest() to display all colours up to 255
--
-- Example usage:
-- tlp.logging.error("The Shadow Lords butt was not found to kick!", 5) -- Displays "[Error] The Shadow Lords butt was not found to kick!" in colour 5.
-- tlp.logging.error("Default colour message") -- Displays "[Error] Default colour message" in colour 68.
-------------------------------------------------------------------------------
tlp.logging.error = function(msg,col)
    if col and not tonumber(col) then
        tlp.logging.error("[Error] Colour value must be a number. Defaulting to colour 68.")
        col = 68 -- Default to a safe value
    end

    local colour = col or 68
    gFunc.Echo(colour, "[Error] "..msg)
end

-------------------------------------------------------------------------------
-- tlp.logging.debug
-- @param msg string The Message you want to display. This will be prefixed with "[Debug]". This will only trigger if you have debug mode enabled (`/lac debug` in-game)
-- @param col number The number assignment for the colour you want to display. Use tlp.utils.colourTest() to display all colours up to 255
--
-- Example usage:
-- tlp.logging.debug("Looking for the Shadow Lord!", 5) -- Displays "[Debug] Looking for the Shadow Lord!" in colour 5.
-- tlp.logging.debug("Default colour message") -- Displays "[Debug] Default colour message" in colour 68.
-------------------------------------------------------------------------------
tlp.logging.debug = function(msg,col)
    if tlp.helpers.debugEnabled() then
        if col and not tonumber(col) then
            tlp.logging.error("[Debug] Colour value must be a number. Defaulting to colour 3.")
            col = 3 -- Default to a safe value
        end

        local colour = col or 3
        gFunc.Echo(colour, "[Debug] "..msg)
    end
end

if tlp.logging then
    if not tlp.settings.user.silentLoad then
        gFunc.Echo(143, "[TLP Load] TheLACPack Logging loaded successfully.")
    end
end