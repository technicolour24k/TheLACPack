--[[
    Various general utility functions for LUAshitacast
]]--

tlp = tlp or {}
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