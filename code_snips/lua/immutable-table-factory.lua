local function make_readonly(target_table)
    local proxy = {}

    local mt = {
        -- Pass-through read operations via rawget
        __index = function(_, key)
            return rawget(target_table, key)
        end,

        -- Intercept and block write operations
        __newindex = function(_, key, _)
            error(
                "Attempt to modify read-only table at key: " .. tostring(key),
                2
            )
        end,

        -- Optional: Protect the metatable from being changed or retrieved via getmetatable
        __metatable = "This metatable is locked.",
    }

    return setmetatable(proxy, mt)
end

-- Example Usage
local config = make_readonly({
    host = "127.0.0.1",
    port = 8080,
    debug = true,
})
