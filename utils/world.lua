--[[
    Various general game related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.world = tlp.xi.world or {}

tlp.xi.world.sendCommand = function(cmd)
    AshitaCore:GetChatManager():QueueCommand(-1, cmd);
end

tlp.xi.world.buffActive = function(buff)
    if (gData.GetBuffCount(buff) >0) then
		tlp.logging.debug("Buff found: "..buff)
        return true
    else
		tlp.logging.debug("Buff not found: "..buff)
        return false
    end
end

tlp.xi.world.clearStatuses = function()
    -- Fail-safe: Ensure this only runs if enabled in config
    if not tlp.settings.user.oneClickRemedies then
        return
    end

    -- Get remedy items from user settings
    local statusItems = tlp.settings.user.statusItems
    if not statusItems then
        gFunc.Echo(68, "[TLP.xi Warning] No remedy items configured in user settings.")
        return
    end

    -- Iterate through each item and check for active statuses
    for _, item in ipairs(statusItems) do
        for _, status in ipairs(item.statuses) do
            if tlp.xi.world.buffActive(status) then
                tlp.logging.debug(string.format("[TLP] Found active status: %s. Using item: %s.", status, item.name))
                tlp.xi.world.sendCommand(string.format('/item "%s" <me>', item.name))
                break -- Stop checking further statuses for this item
            end
        end
    end
end

-- dayWeatherCheck documentation
-- Checks the weather and day elements against the given element and returns match details.
--
-- @param ele: The element to check against the weather and day elements. 
--             Must be one of: Fire, Earth, Water, Wind, Ice, Thunder, Light, Dark.
-- @param skill: (Optional) The skill name being checked, used for debugging purposes.
-- 
-- @return table: A table with the following keys:
--                - isWeatherMatch (boolean): True if the weather matches the given element.
--                - isDayMatch (boolean): True if the day matches the given element.
--                - weatherMultiplier (number): 
--                    - 0 if no match.
--                    - 1 if single weather matches.
--                    - 2 if double weather matches.
--
-- Example usage: 
-- local result = tlp.xi.world.dayWeatherCheck(gData.GetAction().Element , gData.GetAction().Skill)
-- if result.isWeatherMatch then
--     gFunc.Echo(2, "Weather matches Fire! Multiplier: " .. result.weatherMultiplier)
-- end
-- if result.isDayMatch then
--     gFunc.Echo(2, "Day matches Fire!")
-- end
tlp.xi.world.dayWeatherCheck = function(ele, skill)
    -- Validate inputs
    if not ele or ele == "" then
        tlp.logging.error("[dayWeatherCheck] Invalid element provided.")
        return { isWeatherMatch = false, isDayMatch = false, weatherMultiplier = 0 }
    end

    -- Fetch environment data
    local env = gData.GetEnvironment()
    if not env then
        tlp.logging.error("[dayWeatherCheck] Failed to retrieve environment data.")
        return { isWeatherMatch = false, isDayMatch = false, weatherMultiplier = 0 }
    end

    -- Extract relevant data
    local weatherElement = env.WeatherElement or "None"
    local dayElement = env.DayElement or "Unknown"
    local weather = env.Weather or "Unknown"

    -- Single debug log statement
    tlp.logging.debug(
        string.format(
            "[dayWeatherCheck] Skill: %s | Element: %s | WeatherElement: %s | DayElement: %s | Weather: %s",
            tostring(skill), tostring(ele), tostring(weatherElement), tostring(dayElement), tostring(weather) )
    )

    -- Determine matches
    local isWeatherMatch = ele == weatherElement
    local isDayMatch = ele == dayElement

    -- Determine weather multiplier
    local weatherMultiplier = 0
    if isWeatherMatch then
        if weather:find("x2") then
            weatherMultiplier = 2
        else
            weatherMultiplier = 1
        end
    end

    -- Return results
    return {
        isWeatherMatch = isWeatherMatch,
        isDayMatch = isDayMatch,
        weatherMultiplier = weatherMultiplier
    }
end


if not tlp.settings.user.silentLoad then
    if tlp.xi.world then
        gFunc.Echo(143, "[TLP Load] TheLACPack Game World Utilities loaded successfully.")
    end
end