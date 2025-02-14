local string = require("string")

local M = {}

M.LINE_CLEAR = string.format("%c[2K", 27)

return M
