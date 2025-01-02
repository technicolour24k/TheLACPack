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


if tlp.utils then
    if not tlp.settings.user.silentLoad then
        gFunc.Echo(143, "[TLP Load] TheLACPack Utilities loaded successfully.")
    end
end