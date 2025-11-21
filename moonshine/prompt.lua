local termio = require("posix.termio")
local unistd = require("posix.unistd")

local bit = require("bit")
local io = require("io")
local string = require("string")

local utils = require("moonshine.utils")

local M = {}

local function get_raw_input(prompt, fh)
  fh = fh or io.stderr
  fh:write(string.format("%s ", prompt))
  fh:flush()
  return io.read("*l")
end

---Get input from the user.
---@param prompt string The prompt to display to the user.
---@param secret boolean? Whether input should be shown in the terminal.
---@param fh any? The file header to use to print the prompt (defaults to stderr).
---@return string
function M.get_input(prompt, secret, fh)
  secret = secret or false
  if secret then
    return M.get_pass(prompt, fh)
  else
    return get_raw_input(prompt, fh)
  end
end

---Get secret input from the user. This will not print the input from the user to the terminal.
---@param prompt string The prompt to display to the user.
---@param fh any? The file header to use to print the prompt (defaults to stderr).
---@return string
function M.get_pass(prompt, fh)
  fh = fh or io.stderr
  local fd = unistd.STDIN_FILENO
  local old = termio.tcgetattr(fd)
  local new = utils.deep_copy(old)
  new.lflag = bit.band(new.lflag, bit.bnot(termio.ECHO))
  local tcsetattr_flags = termio.TCSAFLUSH
  if termio.TCSASOFT then
    tcsetattr_flags = bit.bor(tcsetattr_flags, termio.TCSASOFT)
  end
  termio.tcsetattr(fd, tcsetattr_flags, new)
  local response = get_raw_input(prompt)
  termio.tcsetattr(fd, tcsetattr_flags, old)
  fh:write("\n")
  fh:flush()
  return response
end

---Request a confirmation from the user.
---@param prompt string The prompt to display to the user.
---@param fh any? The file header to use to print the prompt (defaults to stderr).
---@return boolean
function M.confirm(prompt, fh)
  prompt = string.format("%s (y/N)?", prompt)
  local res = get_raw_input(prompt, fh)
  return string.match(res, "^%s*[yY][eE]?[sS]?%s*$")
end

return M
