--[[
    General midcast rules to equip a defined set structure (sets.midcast.x)
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.midcast = tlp.xi.rules.midcast or {}

tlp.xi.rules.midcast = {
    spell = function(sets, spell)
        if sets.midcast[spell] then
            gFunc.EquipSet(sets.midcast[spell])
        else
            tlp.logging.debug(string.format("Set not found: sets.midcast[%s]", spell))
        end
    end,

    skill = function(sets, skill)
        if sets.midcast[skill] then
            gFunc.EquipSet(sets.midcast[skill])
        else
            tlp.logging.debug(string.format("Set not found: sets.midcast[%s]", skill))
        end
    end,
}

-- Set the table to behave like a function
setmetatable(tlp.xi.rules.midcast, {
    __call = function(self, sets, spell, skill)
        local action = gData.GetAction() -- Use gData.GetAction() for action details
        if action then
            tlp.logging.debug("gData.GetAction().Name: " .. tostring(action.Name))
            tlp.logging.debug("gData.GetAction().Skill: " .. tostring(action.Skill))
            tlp.logging.debug("gData.GetAction().Type: " .. tostring(action.Type))
            tlp.logging.debug("gData.GetAction().Element: " .. tostring(action.Element))
        else
            tlp.logging.error("gData.GetAction() returned nil")
        end

        tlp.xi.actions.cancelBuff(gData.GetAction().Name,gData.GetAction().CastTime, gSettings.FastCast)
        self.skill(sets, skill)
        self.spell(sets, spell)
    end
})