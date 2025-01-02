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

tlp.helpers = tlp.helpers or {}

tlp.helpers.debugEnabled = function()
    if (gSettings.Debug) then
		return true
	else
		return false
	end
end


tlp.helpers.buffActive = function(buff)
    if (gData.GetBuffCount(buff) >0) then
        return true
    else
        return false
    end
end



tlp.utils = tlp.utils or {}

tlp.utils.colourTest = function()
    for i = 1, 255, 1 do
        gFunc.Echo(i, "Colour test: "..i)
    end
end

-- itemInArray documentation
-- Checks through a table for a specific phrase
-- @param tab: The table to check
-- @param val: The value we're looking in the table for
-- Example usage: tlp.utils.itemInArray(my.table, "Stonega")
-- Example usage: tlp.utils.itemInArray(my.table, gData.action.Name)
tlp.utils.itemInArray = function (tbl, val)
    for index, value in ipairs(tbl) do
        if value == val then
            return true
        end
    end
    return false
end

-- wait documentation
-- @param time: The time you want to wait, in seconds
-- Example usage: tlp.utils.wait(5) - Waits for 5 seconds then drops back out.
tlp.utils.wait = function(time)
	coroutine.sleep(time)
	return true
end


if not tlp.settings.user.silentLoad then
    if tlp.utils then
        gFunc.Echo(143, "[TLP Load] TheLACPack Utilities loaded successfully.")
    end
end