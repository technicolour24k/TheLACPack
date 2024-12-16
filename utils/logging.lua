require('helpers')

--[[
    Various logging options
]]--

tlp = tlp or {}
tlp.logging = tlp.logging or {}

tlp.logging.info = function(msg,col)
    local colour = col or 2
    gFunc.Echo(colour, "[Info] "..msg)
end

tlp.logging.error = function(msg,col)
    local colour = col or 68
    gFunc.Echo(colour, "[Error] "..msg)
end

tlp.logging.debug = function(msg,col)
    if tlp.helpers.debugEnabled() then
        local colour = col or 3
        gFunc.Echo(colour, "[Debug] "..msg)
    end
end