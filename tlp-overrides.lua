--[[
    Various action (JA/WS/Spell) related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.actions = tlp.xi.actions or {}

-- spellContains documentation
-- @param spell: The name of the spell you're comparing against. Recommendation: gData.GetAction().Name
-- @param contains: The string you're looking for
tlp.xi.actions.spellContains = function(spell, contains)
    tlp.logging.info("I'm checking your contains now")
    return string.find(spell:lower(), contains:lower()) ~= nil
end