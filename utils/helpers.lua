--[[
    Various helper functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.helpers = tlp.helpers or {}
gFunc.Echo(143, "v0.2")
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


-- if not tlp.settings.user.silentLoad then
--     if tlp.helpers then
--         gFunc.Echo(143, "[TLP Load] TheLACPack Helpers loaded successfully.")
--     end
-- end