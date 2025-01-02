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
    return string.find(spell:lower(), contains:lower()) ~= nil
end

tlp.xi.actions.enemyImmunityCheck = function(mob, spell)
    local immunities = tlp.xi.data.enemyImmunities[mob]

    -- No immunities defined for this mob
    if not immunities then
        return
    end

    -- Check if the spell matches any immunity
    for _, immunity in ipairs(immunities) do
        if tlp.xi.utils.spellContains(spell, immunity) then
            tlp.xi.logging.info(string.format("[TLP.xi] %s is immune to %s. Cancelling spell.", mob, immunity))
            gFunc.CancelAction()
            return
        end
    end
end


-- Helper function to calculate delay
local function calculateDelay(castTime, fastCastAmount)
    if fastCastAmount <= 0 then
        return castTime * (1-tlp.xi.settings.user.cancellationMargin) -- No Fast Cast, so cancel at the end of the cast time
    end

    local fastCastMultiplier = ((100 - fastCastAmount) / 100) * 0.3
    local delayToCancel = castTime - (castTime * fastCastMultiplier)
    delayToCancel = delayToCancel - (castTime * tlp.xi.settings.user.cancellationMargin)

    return math.max(0, delayToCancel) -- Make sure we get the highest cancellation delay
end


-- Helper function for logging Fast Cast information
local function logFastCastInfo(spell, castTime, fastCastAmount, delay, buff)
        tlp.xi.logging.debug(string.format(
            "[FastCastInfo] Spell: %s, Base Cast Time: %.2fs, Fast Cast: %d%%, Delay to Cancel: %.2fs, Buff: %s",
            spell, castTime/1000, fastCastAmount, delay, buff
        ))
end

-- Helper function to execute cancel command
local function executeCancel(spellOrBuff, delay, typeInfo)
    tlp.xi.utils.wait(delay)
    tlp.xi.world.sendCommand('/cancel ' .. spellOrBuff)
    tlp.xi.logging.debug(string.format("Cancelled %s after %.2fs [%s]", spellOrBuff, delay, typeInfo))
end

-- Main function
tlp.xi.actions.cancelBuff = function(spell, castTime, fastCastAmount, buff, skill)
    fastCastAmount = fastCastAmount or gSettings.FastCast
    -- Validate inputs
    if not spell or not castTime or not fastCastAmount then
        tlp.xi.logging.error("Invalid parameters passed to cancelBuff function.")
        return
    end

    -- Fetch the user-defined autoCancelList
    local autoCancelList = tlp.xi.settings.user.autoCancelList
    if not autoCancelList or not tlp.xi.utils.itemInArray(autoCancelList, spell) then
        return
    end

    -- Determine the actual buff to cancel
    local actualBuff = buff or spell

    -- Calculate delay based on Fast Cast and skill type
    local delay = 0
    if skill ~= "JobAbility" and skill ~= "Jig" then
        delay = calculateDelay(castTime, fastCastAmount)/1000
    end

    -- Log Fast Cast information
    logFastCastInfo(spell, castTime, fastCastAmount, delay)


    -- Execute cancel command
    executeCancel(actualBuff, delay, buff and "Buff Parameter Sent" or "Spell")
end




tlp.xi.world = tlp.xi.world or {}

tlp.xi.world.sendCommand = function(cmd)
    AshitaCore:GetChatManager():QueueCommand(-1, cmd);
end

tlp.xi.world.buffActive = function(buff)
    if (gData.GetBuffCount(buff) >0) then
		tlp.xi.logging.debug("Buff found: "..buff)
        return true
    else
		tlp.xi.logging.debug("Buff not found: "..buff)
        return false
    end
end

tlp.xi.world.clearStatuses = function()
    -- Fail-safe: Ensure this only runs if enabled in config
    if not tlp.xi.settings.user.oneClickRemedies then
        return
    end

    -- Get remedy items from user settings
    local statusItems = tlp.xi.settings.user.statusItems
    if not statusItems then
        gFunc.Echo(68, "[TLP.xi Warning] No remedy items configured in user settings.")
        return
    end

    -- Iterate through each item and check for active statuses
    for _, item in ipairs(statusItems) do
        for _, status in ipairs(item.statuses) do
            if tlp.xi.world.buffActive(status) then
                tlp.xi.logging.debug(string.format("[TLP.xi] Found active status: %s. Using item: %s.", status, item.name))
                tlp.xi.world.sendCommand(string.format('/item "%s" <me>', item.name))
                break -- Stop checking further statuses for this item
            end
        end
    end
end

