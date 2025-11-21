local spinner = require("moonshine.spinner")
local text = require("luatext")

local os = require("os")

local spinners = {}
for _, symbol in ipairs(spinner.SPINNERS.ROTATING_DOTS) do
  spinners[#spinners + 1] = text.Text:new(symbol):fg(text.Color.Red):render()
end

local a, b = spinner.wrap(function(linda)
  os.execute("sleep 2s")
  linda:send("update", "still waiting...")
  os.execute("sleep 2s")
  return 1, 2
end, "waiting...", spinners)

assert(a == 1, "a should be 1")
assert(b == 2, "b should be 2")

local ligature_spinners = {}
for _, symbol in ipairs({ "\u{ee06}", "\u{ee07}", "\u{ee08}", "\u{ee09}", "\u{ee0a}", "\u{ee0b}" }) do
  ligature_spinners[#ligature_spinners + 1] = text.Text:new(symbol):fg(text.Color.Red):render()
end

spinner.wrap(function()
  os.execute("sleep 3s")
end, "waiting...", ligature_spinners)
