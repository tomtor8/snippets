local function is_digit(char)
    local b = string.byte(char)
    -- ASCII '0' is 48, '9' is 57
    return b and b >= 48 and b <= 57
end

local function is_upper(char)
    local b = string.byte(char)
    -- ASCII 'A' is 65, 'Z' is 90
    return b and b >= 65 and b <= 90
end

print(is_digit("7")) -- true
print(is_upper("N")) -- true
