local http = require("socket.http")
local lfs = require("lfs.lfs_ffi")

-- Resolve addon dir and cache root
local script_path = debug.getinfo(1, "S").source:sub(2)
local addon_dir = script_path:match("^(.*)[/\\]") or "."
local CACHE_ROOT = addon_dir .. "/tlp-cache"

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
        forceRefresh = false, -- Default: Do not force refresh
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
local cache_root = CACHE_ROOT .. "/" .. ver .. "/"

-- Helpers
local function should_log()
    return not tlp.settings.user.silentLoad
end

local function log(msg)
    if should_log() then
        gFunc.Echo(68, "[TLP] " .. msg)
    end
end

local function ensure_dirs(path)
    local dir = path:match("^(.*)/[^/]+$")
    if not dir or dir == "" then return end
    local acc = ""
    for part in dir:gmatch("([^/]+)") do
        acc = acc == "" and part or (acc .. "/" .. part)
        lfs.mkdir(acc)
    end
end

local function atomic_write(path, contents)
    ensure_dirs(path)
    local tmp = path .. ".tmp"
    local f = assert(io.open(tmp, "wb"))
    f:write(contents)
    f:close()
    assert(os.rename(tmp, path))
end

local core_files = {
    "utils/helpers.lua",
    "utils/utils.lua",
    "utils/actions.lua",
    "utils/world.lua",
    "utils/logging.lua",
    "rules/midcast.lua",
}

local data_files = {
    "data/enemy-immunities.lua",
}

-- Function to fetch and load a remote Lua file
local function fetch_and_load(file_name, opts)
    opts = opts or {}
    local cache_path = cache_root .. file_name
    local use_cache = not opts.force and not tlp.settings.user.forceRefresh

    if use_cache then
        local attr = lfs.attributes(cache_path, "mode")
        if attr == "file" then
            local chunk, err = loadfile(cache_path)
            if chunk then
                log("Loaded from cache: " .. file_name)
                return chunk()
            else
                log("Cache corrupt for " .. file_name .. ": " .. tostring(err) .. " (refetching)")
            end
        end
    end

    local url = base_url .. file_name
    log("Downloading: " .. file_name .. " -> " .. cache_path)
    local response, status = http.request(url)
    if status ~= 200 then
        error("Failed to fetch " .. file_name .. ": HTTP status " .. tostring(status))
    end

    atomic_write(cache_path, response)

    local chunk, err = load(response, file_name)
    if not chunk then
        error("Error loading chunk from " .. file_name .. ": " .. err)
    end
    return chunk()
end

local function reload_cache()
    log("Forcing cache refresh...")
    tlp.settings.user.forceRefresh = true
    for _, file_name in ipairs(core_files) do
        fetch_and_load(file_name, { force = true })
    end
    for _, file_name in ipairs(data_files) do
        fetch_and_load(file_name, { force = true })
    end
    tlp.settings.user.forceRefresh = false
    log("Cache refresh complete.")
end

-- Load core framework files
for _, file_name in ipairs(core_files) do
    fetch_and_load(file_name)
end

-- Load data files
for _, file_name in ipairs(data_files) do
    fetch_and_load(file_name)
end

-- Load custom overrides. This has to be the last thing otherwise your overrides won't take effect.
gFunc.LoadFile("../custom-functions.lua")
gFunc.LoadFile("../tlp-overrides.lua")

-- Expose fetch_and_load to profiles
return {
    fetch_and_load = fetch_and_load,
    reload_cache = reload_cache,
}
