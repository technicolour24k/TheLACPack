local http = require("socket.http")

-- Attempt to load user configuration file
local function load_user_config()
    local success, err = pcall(function()
        -- Load TLP config
        gFunc.LoadFile("./tlp-settings.lua")
    end)
    if not success then
        gFunc.Echo(68, "[TLP Warning] User config file not found or failed to load: " .. tostring(err))
    end

    -- Ensure global settings structure exists
    tlp = tlp or {}
    tlp.settings = tlp.settings or {}

    -- Define default settings (fallbacks)
    local default_config = {
        version = "main",  -- Default branch
    }
    local default_user = {
        silentLoad = false, -- Default: Show load messages
    }

    -- Merge default config settings
    tlp.settings.config = tlp.settings.config or {}
    for key, default_value in pairs(default_config) do
        if tlp.settings.config[key] == nil then
            tlp.settings.config[key] = default_value
        end
    end

    -- Merge default user settings
    tlp.settings.user = tlp.settings.user or {}
    for key, default_value in pairs(default_user) do
        if tlp.settings.user[key] == nil then
            tlp.settings.user[key] = default_value
        end
    end
end

-- Load user config
load_user_config()

-- Framework setup using user-defined branch
local ver = tlp.settings.config.version or "main"
local base_url = "https://raw.githubusercontent.com/technicolour24k/thelacpack/" .. ver .. "/"

-- Function to fetch and load a remote Lua file
local function fetch_and_load(file_name)
    local url = base_url .. file_name
    local response, status = http.request(url)
    if status == 200 then
        local chunk, err = load(response, file_name)
        if not chunk then
            error("Error loading chunk from " .. file_name .. ": " .. err)
        end
        return chunk()
    else
        error("Failed to fetch " .. file_name .. ": HTTP status " .. status)
    end
end

-- Load core framework files
fetch_and_load("utils/helpers.lua")
fetch_and_load("utils/utils.lua")
fetch_and_load("utils/actions.lua")
fetch_and_load("utils/world.lua")
fetch_and_load("utils/logging.lua")

-- Load data files
fetch_and_load("data/enemy-immunities.lua")


-- Expose fetch_and_load to profiles
return {
    fetch_and_load = fetch_and_load
}
