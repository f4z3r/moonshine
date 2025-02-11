local package_version = "0.1.0"
rockspec_format = "3.0"
package = "moonshine"
version = package_version .. "-0"
source = {
  url = "git://github.com/f4z3r/moonshine.git",
  tag = "v" .. package_version,
}
description = {
  summary = "A library to make CLIs beautiful.",
  detailed = [[
     TODO
   ]],
  homepage = "https://github.com/f4z3r/moonshine/tree/main",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
}
build = {
  type = "builtin",
  modules = {
    moonshine = "./moonshine/init.lua",
  },
}
