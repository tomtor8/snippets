#!/usr/bin/env lua

local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/Code/lua/modules/?.lua"
