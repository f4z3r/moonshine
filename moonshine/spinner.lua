local lanes = require("lanes")

local io = require("io")
local string = require("string")
local table = require("table")

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

---Wraps a function in a spinner.
---@param func function(any): varargs the function to wrap, which takes a linda to send text updates to the spinner.
---@param text string the initial text to display next to the spinner
---@param symbols string[]? the symbols to use for the spinner
---@param interval number? the interval at which to render the spinner
function M.wrap(func, text, symbols, interval, width)
  symbols = symbols or M.SPINNERS.ROTATING_DOTS
  interval = interval or DEFAULT_INTERVAL
  width = width or 80
  width = width - string.len(symbols[1])
  local text_update_channel = lanes.linda()

  local function render(sym, suffix, inter, w)
    local time = require("posix.time")
    local format = "\r %s %-" .. w .. "s"
    while true do
      for _, s in ipairs(sym) do
        local _, update = text_update_channel:receive(0.0, "update")
        if update ~= nil then
          suffix = update
        end
        io.stdout:write(string.format(format, s, suffix))
        io.stdout:flush()
        time.nanosleep({ tv_sec = 0, tv_nsec = inter })
      end
    end
  end

  local spinner = lanes.gen("io,string,package", render)
  local proc = spinner(symbols, text, interval * MILLI_TO_NANO, width)
  local out = { func(text_update_channel) }
  proc:cancel()
  return table.unpack(out)
end

return M
