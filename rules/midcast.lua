--[[
    Various action (JA/WS/Spell) related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.midcast = tlp.xi.rules.midcast or {}

tlp.xi.rules.midcast.spell =  function (sets, spell)
    if (sets[spell]) then
        gFunc.EquipSet(sets[spell])
    else
        tlp.logging.debug(string.format("Set not found: sets[%s]",spell))
    end
end

tlp.xi.rules.midcast.skill = function (sets, skill)
    if (sets[skill]) then
        gFunc.EquipSet(sets[skill])
    else
        tlp.logging.debug(string.format("Set not found: sets[%s]",skill))
    end
end

tlp.xi.rules.midcast = function (sets,spell,skill)
    tlp.xi.rules.midcast.skill(sets,skill)
    tlp.xi.rules.midcast.skill(sets,spell)
end
