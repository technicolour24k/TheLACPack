--[[
    Various helper functions for LUAshitacast
]]--

tlp = tlp or {}
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