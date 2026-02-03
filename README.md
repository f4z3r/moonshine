<div align="center">

<img src="./assets/logo.jpeg" alt="Moonshine" width="50%">

# Moonshine

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/f4z3r/moonshine/lint-and-test.yml)
![GitHub License](https://img.shields.io/github/license/f4z3r/beancount?link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fmoonshine%2Fblob%2Fmain%2FLICENSE)
![GitHub Release](https://img.shields.io/github/v/release/f4z3r/moonshine?logo=github&link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fmoonshine%2Freleases)
![LuaRocks](https://img.shields.io/luarocks/v/f4z3r/moonshine?logo=lua&link=https%3A%2F%2Fluarocks.org%2Fmodules%2Ff4z3r%2Fmoonshine)

### A library to build beautiful command line tools in Lua(JIT).

[About](#about) |
[Example](#example) |
[Usage](#reference) |
[Installation](#installation) |
[Development](#development)

<hr />
</div>

## About

A library for making CLI applications beautiful. It mains to provide the basic building blocks that
CLIs need to be beautiful (progress bars, spinners, prompts, etc). It does not attempt to be a
proper TUI framework.

## Example

A simple example on how to print a spinner with updating text during a long function execution:

```lua
local spinner = require("moonshine.spinner")

local a, b = spinner.wrap(function(linda)
  os.execute("sleep 2s")
  linda:send("update", "still waiting...")
  os.execute("sleep 2s")
  return 1, 2
end, "waiting...", spinners)

assert(a == 1, "a should be 1")
assert(b == 2, "b should be 2")
```

More examples can be seen under the [`examples/`](./examples/) directory.

## Reference

For a full reference of the API, see [the reference](/docs/reference.md).

## Installation

> [!NOTE]
> This library is mostly tested in practice with LuaJIT. I do not test it regularly with other Lua
> versions.


This module is hosted on LuaRocks and can thus be installed via:

```bash
luarocks install moonshine
```

## Development

You can setup a dev environment with the needed Lua version:

```bash
# launch shell with some lua version and the dependencies installed:
nix develop .#lua52
```

and then test with `busted`.
