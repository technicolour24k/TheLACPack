tlp = tlp or {}
tlp.settings = tlp.settings or {}

tlp.settings.config = tlp.settings.config or {
    -- Version refers to the branch that you want to use. "main" is the most stable, and least likely to change, but is not explicitly version controlled. Feel free to review the available branches here:
    -- https://github.com/technicolour24k/TheLACPack/branches
    version = "main"
}

tlp.settings.user = tlp.settings.user or {
    silentLoad = false,  -- Default: false, always show loading messages
    oneClickRemedies = true, -- Default: true, enable one-button status removals
    statusItems = {
        { name = "Holy Water", statuses = { "Curse", "Doom" } },
        { name = "Hallowed Water", statuses = { "Curse", "Doom" } },
        { name = "Remedy", statuses = { "Blind", "Paralysis", "Silence", "Poison" } },
        { name = "Rmdy. Ointment", statuses = { "Disease", "Plague" } },
        { name = "Panacea", statuses = { 
            "Bind", "Bio", "Burn", "Choke", "Dia", "Flash", 
            "Frost", "Gravity", "Rasp", "Slow", "Stun", "Weight", 
            "Attack Down", "Defense Down", "STR Down", "AGI Down", 
            "DEX Down", "VIT Down", "INT Down", "MND Down", 
            "Max HP Down", "Max MP Down" 
        } }
    },
    blockEnemyImmunities = true, -- Default: true, actively try to stop casting against things that are immune
}

