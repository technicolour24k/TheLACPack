--[[
    General precast rules to equip a defined set structure (sets.precast.x)
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.precast = tlp.xi.rules.precast or {}

tlp.xi.rules.precast = {
    spell = function(sets, spell)
        if sets.precast[spell] then
            gFunc.EquipSet(sets.precast[spell])
        else
            tlp.logging.debug(string.format("Set not found: sets.precast[%s]", spell))
        end
    end,

    skill = function(sets, skill)
        if sets.precast[skill] then
            gFunc.EquipSet(sets.precast[skill])
        else
            tlp.logging.debug(string.format("Set not found: sets.precast[%s]", skill))
        end
    end,
}

-- Set the table to behave like a function
setmetatable(tlp.xi.rules.precast, {
    __call = function(self, sets, spell, skill)
        tlp.xi.actions.enemyImmunityCheck(gFunc.getActionTarget().Name, gFunc.getAction().Name) -- Fire off the immunity check, based on whether or not tlp.settings.user.blockEnemyImmunities is enabled
        gFunc.EquipSet(sets.precast.default)
        self.skill(sets, skill)
        self.spell(sets, spell)
    end
})