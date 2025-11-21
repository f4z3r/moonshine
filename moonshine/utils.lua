local string = require("string")

local M = {}

M.LINE_CLEAR = string.format("%c[2K", 27)

---Performs a deep copy of the object provided.
---@param obj any The object to deep copy.
---@return any
function M.deep_copy(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end
  if seen and seen[obj] then
    return seen[obj]
  end

  local s = seen or {}
  local res = {}
  s[obj] = res
  for k, v in pairs(obj) do
    res[M.deep_copy(k, s)] = M.deep_copy(v, s)
  end
  return setmetatable(res, getmetatable(obj))
end

return M
