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
    if not tlp.settings.user.blockEnemyImmunities then
        tlp.logging.debug("[enemyImmunityCheck] tlp.settings.user.blockEnemyImmunities is false")
        return
    end

    local immunities = tlp.data.enemyImmunities[mob]

    -- No immunities defined for this mob
    if not immunities then
        return
    end

    -- Check if the spell matches any immunity
    for _, immunity in ipairs(immunities) do
        if tlp.utils.spellContains(spell, immunity) then
            tlp.logging.info(string.format("[TLP.xi] %s is immune to %s. Cancelling spell.", mob, immunity))
            gFunc.CancelAction()
            return
        end
    end
end


-- Helper function to calculate delay
local function calculateDelay(castTime, fastCastAmount)
    if fastCastAmount <= 0 then
        return castTime * (1-tlp.settings.cancellationMargin) -- No Fast Cast, so cancel at the end of the cast time
    end

    local fastCastMultiplier = ((100 - fastCastAmount) / 100) * 0.3
    local delayToCancel = castTime - (castTime * fastCastMultiplier)
    delayToCancel = delayToCancel - (castTime * tlp.settings.user.cancellationMargin)

    return math.max(0, delayToCancel) -- Make sure we get the highest cancellation delay
end


-- Helper function for logging Fast Cast information
local function logFastCastInfo(spell, castTime, fastCastAmount, delay, buff)
        tlp.logging.debug(string.format(
            "[FastCastInfo] Spell: %s, Base Cast Time: %.2fs, Fast Cast: %d%%, Delay to Cancel: %.2fs, Buff: %s",
            spell, castTime/1000, fastCastAmount, delay, buff
        ))
end

-- Helper function to execute cancel command
local function executeCancel(spellOrBuff, delay, typeInfo)
    tlp.utils.wait(delay)
    tlp.xi.world.sendCommand('/cancel ' .. spellOrBuff)
    tlp.logging.debug(string.format("Cancelled %s after %.2fs [%s]", spellOrBuff, delay, typeInfo))
end

-- Main function
tlp.xi.actions.cancelBuff = function(spell, castTime, fastCastAmount, buff, skill)
    fastCastAmount = fastCastAmount or gSettings.FastCast
    -- Validate inputs
    if not spell or not castTime or not fastCastAmount then
        tlp.logging.error("Invalid parameters passed to cancelBuff function.")
        return
    end

    -- Fetch the user-defined autoCancelList
    local autoCancelList = tlp.settings.user.autoCancelList
    if not autoCancelList or not tlp.utils.itemInArray(autoCancelList, spell) then
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

if not tlp.settings.user.silentLoad then
    if tlp.xi.actions then
        gFunc.Echo(143, "[TLP Load] TheLACPack Action Utilities loaded successfully.")
    end
end