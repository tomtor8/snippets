-- OPTION 1

local function is_accented_pattern(char)
    -- Check if the character exists inside a defined character set
    return string.match(
        char,
        "[áéíóúýáäčďéíĺľňñóôŕšťúýžÁÉÍÓÚÝÄČĎÉÍĹĽŇÑÓÔŔŠŤÚÝŽ]"
    ) ~= nil
end

print(is_accented_pattern("á")) -- true
print(is_accented_pattern("x")) -- false

-- OPTION 2

local function is_accented(char)
    -- Decodes the UTF-8 sequence into its full Unicode codepoint
    local cp = utf8.codepoint(char)

    -- Check specific Unicode ranges for accented Latin letters:
    -- 0x00C0 to 0x024F covers Latin-1 Supplement & Extended (á, é, š, č, ñ, etc.)
    return cp and cp >= 0x00C0 and cp <= 0x024F
end

print(is_accented("á")) -- true
print(is_accented("š")) -- true
print(is_accented("N")) -- false
