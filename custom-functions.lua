--[[
    User defined functions to extend TLP for your local environment
]]--

tlp = tlp or {}
tlp.user = tlp.user or {}
tlp.user.functions = tlp.user.functions or {}

--[[ 
    tlp.user.functions.FUNCTION_NAME = function(params)
        logic
    end

    Call with tlp.user.functions.FUNCTION_NAME(params)

    Example:
        tlp.user.functions.announceSpell = function(spell,target,chatmode)
	        local announcementList = T{"Accomplice","Collaborator","Stun", "Shadowbind"}
	        if (announcementList:contains(spell)) then
		        sendCommand('/'..chatmode..' '..spell..' => '..target)
	        end
        end
]]--