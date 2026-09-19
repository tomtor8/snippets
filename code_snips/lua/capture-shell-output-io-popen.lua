---Execute a shell command and capture its stdout
---@param cmd string
---@return string|nil
local function capture(cmd)
    local handle = io.popen(cmd)
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    return result and result:gsub("%s+$", "") or nil
end

-- usage
local output = capture("some command")
