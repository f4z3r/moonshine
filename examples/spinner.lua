local spinner = require("moonshine.spinner")
local os = require("os")

spinner.wrap(function()
  os.execute("sleep 5s")
end, "waiting...", spinner.SPINNERS.MOVING_DOTS, 300)
