--[[
    Various action (JA/WS/Spell) related utility functions for LUAshitacast
]]--

tlp = tlp or {}
tlp.actions = tlp.actions or {}

-- spellContains documentation
-- @param spell: The name of the spell you're comparing against. Recommendation: gData.GetAction().Name
-- @param contains: The string you're looking for
tlp.actions.spellContains = function(spell, contains)
    return string.find(spell:lower(), contains:lower()) ~= nil
end

tlp.actions.enemyImmunityCheck = function(mob, spell)
    local immunities = tlp.data.enemyImmunities[mob]

    -- No immunities defined for this mob
    if not immunities then
        return
    end

    -- Check if the spell matches any immunity
    for _, immunity in ipairs(immunities) do
        if tlp.utils.spellContains(spell, immunity) then
            tlp.logging.info(string.format("[TLP] %s is immune to %s. Cancelling spell.", mob, immunity))
            gFunc.CancelAction()
            return
        end
    end
end


if not tlp.settings.user.silentLoad then
    if tlp.actions then
        gFunc.Echo(143, "[TLP Load] TheLACPack Action Utilities loaded successfully.")
    end
end