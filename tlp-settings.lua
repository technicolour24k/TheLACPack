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
    autoCancelList = {  -- List of buffs to be automatically cancelled
        "Enstone", "Enwater", "Enaero", "Enfire", "Enblizzard", "Enthunder",
        "Stoneskin", "Blaze Spikes", "Ice Spikes", "Shock Spikes", "Sneak", "Spectral Jig"
    },
    cancellationMargin = 0.2, -- This is a multiplier for the amount of extra margin to give the tlp.actions.cancelBuff function. 0.2 = Cancelling at 80% 0.4 = 60%, 0.5 = 50%, etc
}

