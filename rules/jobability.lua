--[[
    General abilities rules to equip a defined set structure (sets.abilities.x)
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.abilities = tlp.xi.rules.abilities or {}

tlp.xi.rules.abilities = function (sets,ability)
    local action = gFunc.getAction()
    if (sets.JobAbility[ability]) then
        gFunc.EquipSet(sets.JobAbility[ability])
    end

    if tlp.xi.world.spellContains(ability, "Spectral Jig") then
        tlp.actions.cancelBuff(ability, action.CastTime, gSettings.FastCast, "71")
    end
end