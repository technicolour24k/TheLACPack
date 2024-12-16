local http = require("socket.http")

-- Framework setup
-- Version refers to the branch that you want to use. "main" is the most stable, and least likely to change, but is not explicitly version controlled. Feel free to review the available branches here:
-- https://github.com/technicolour24k/TheLACPack/branches
local version = "main"
local base_url = "https://raw.githubusercontent.com/technicolour24k/thelacpack/"..version

-- Function to fetch and load a remote Lua file
local function fetch_and_load(file_name)
    local url = base_url .."/".. file_name
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

-- Load framework files
fetch_and_load("utils/helpers.lua")
fetch_and_load("utils/logging.lua")  -- Logging utilities

-- Expose fetch_and_load to profiles
return {
    fetch_and_load = fetch_and_load
}