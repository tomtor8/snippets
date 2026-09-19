local function get_os_type()
    local handle = io.popen("uname")
    if not handle then
        print("Couldn't check the OS type. `uname` probably missing. Exiting.")
        os.exit(1)
    end
    local uname_output = handle:read("*a"):gsub("%s*$", "") -- Read all output and trim trailing whitespace
    handle:close()

    if uname_output == "Linux" then
        return "Linux"
    elseif uname_output == "Darwin" then
        -- 'Darwin' is the kernel name for macOS
        return "macOS"
    end
end

-- Using custom ./capture-shell-output-io-popen.lua

local function get_os_type_2()
    capture("uname")
    if uname_output == "Linux" then
        return "Linux"
    elseif uname_output == "Darwin" then
        -- 'Darwin' is the kernel name for macOS
        return "macOS"
    end
end

-- usage
local os_type = get_os_type()
local os_type = get_os_type_2()
