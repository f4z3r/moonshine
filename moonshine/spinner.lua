local lanes = require("lanes")

lanes.configure()

local DEFAULT_INTERVAL = 100
local MILLI_TO_NANO = 1000000

local M = {}

M.SPINNERS = {
  ROTATING_DOTS = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  ROTATING_LINE = { "|", "/", "-", "\\" },
  MOVING_DOTS = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●" },
  ELLIPSIS = { "   ", ".  ", ".. ", "..." },
}

local function render(symbols, text, interval)
  local time = require("posix.time")
  while true do
    for _, s in ipairs(symbols) do
      io.stdout:write("\r" .. s .. " " .. text)
      io.stdout:flush()
      time.nanosleep({ tv_sec = 0, tv_nsec = interval })
    end
  end
end

function M.wrap(func, text, symbols, interval)
  symbols = symbols or M.SPINNERS.ROTATING_DOTS
  interval = interval or DEFAULT_INTERVAL
  local spinner = lanes.gen("io,package", render)
  local proc = spinner(symbols, text, interval * MILLI_TO_NANO)
  func()
  proc:cancel()
end

return M
