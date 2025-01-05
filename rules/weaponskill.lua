--[[
    General weaponskill rules to equip a defined set structure (sets.weaponskill.x)
]]--

tlp = tlp or {}
tlp.xi = tlp.xi or {}
tlp.xi.rules = tlp.xi.rules or {}
tlp.xi.rules.weaponskill = tlp.xi.rules.weaponskill or {}

tlp.xi.rules.weaponskill = function (sets, ws)
    if (sets.WeaponSkills[ws]) then
        gFunc.EquipSet(sets.WeaponSkills[ws])
    end
end