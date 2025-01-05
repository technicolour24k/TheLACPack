--[[
    Various action (JA/WS/Spell) related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.midcast = tlp.xi.rules.midcast or {}

tlp.xi.rules.midcast = {
    spell = function(sets, spell)
        if sets[spell] then
            gFunc.EquipSet(sets[spell])
        else
            tlp.logging.debug(string.format("Set not found: sets[%s]", spell))
        end
    end,

    skill = function(sets, skill)
        if sets[skill] then
            gFunc.EquipSet(sets[skill])
        else
            tlp.logging.debug(string.format("Set not found: sets[%s]", skill))
        end
    end,
}

-- Set the table to behave like a function
setmetatable(tlp.xi.rules.midcast, {
    __call = function(self, sets, spell, skill)
        self.skill(sets, skill)
        self.spell(sets, spell)
        tlp.xi.actions.cancelBuff(gData.GetAction().Name,gData.GetAction().CastTime, gSettings.FastCast)
    end
})