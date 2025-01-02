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
		tlp.xi.logging.debug("Buff found: "..buff)
        return true
    else
		tlp.xi.logging.debug("Buff not found: "..buff)
        return false
    end
end

tlp.xi.world.clearStatuses = function()
    -- Fail-safe: Ensure this only runs if enabled in config
    if not tlp.xi.settings.user.oneClickRemedies then
        return
    end

    -- Get remedy items from user settings
    local statusItems = tlp.xi.settings.user.statusItems
    if not statusItems then
        gFunc.Echo(68, "[TLP.xi Warning] No remedy items configured in user settings.")
        return
    end

    -- Iterate through each item and check for active statuses
    for _, item in ipairs(statusItems) do
        for _, status in ipairs(item.statuses) do
            if tlp.xi.world.buffActive(status) then
                tlp.xi.logging.debug(string.format("[TLP.xi] Found active status: %s. Using item: %s.", status, item.name))
                tlp.xi.world.sendCommand(string.format('/item "%s" <me>', item.name))
                break -- Stop checking further statuses for this item
            end
        end
    end
end

if not tlp.xi.settings.user.silentLoad then
    if tlp.xi.world then
        gFunc.Echo(143, "[TLP.xi Load] TheLACPack Game World Utilities loaded successfully.")
    end
end