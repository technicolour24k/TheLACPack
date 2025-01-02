--[[
    Various general game related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.world = tlp.world or {}

tlp.world.sendCommand = function(cmd)
    AshitaCore:GetChatManager():QueueCommand(-1, cmd);
end

tlp.world.buffActive = function(buff)
    if (gData.GetBuffCount(buff) >0) then
		tlp.logging.debug("Buff found: "..buff)
        return true
    else
		tlp.logging.debug("Buff not found: "..buff)
        return false
    end
end

-- tlp.world.clearStatuses = function()
--     -- Fail-safe: Ensure this only runs if enabled in config
--     if not tlp.settings.user.oneClickRemedies then
--         return
--     end

--     -- Get remedy items from user settings
--     local statusItems = tlp.settings.user.statusItems
--     if not statusItems then
--         gFunc.Echo(68, "[TLP Warning] No remedy items configured in user settings.")
--         return
--     end

--     -- Iterate through each item and check for active statuses
--     for _, item in ipairs(statusItems) do
--         for _, status in ipairs(item.statuses) do
--             if tlp.world.buffActive(status) then
--                 tlp.logging.debug(string.format("[TLP] Found active status: %s. Using item: %s.", status, item.name))
--                 tlp.world.sendCommand(string.format('/item "%s" <me>', item.name))
--                 break -- Stop checking further statuses for this item
--             end
--         end
--     end
-- end

if not tlp.settings.user.silentLoad then
    if tlp.world then
        gFunc.Echo(143, "[TLP Load] TheLACPack Game World Utilities loaded successfully.")
    end
end