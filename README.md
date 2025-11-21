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

A library for making CLI applications beautiful.

> TODO add compatibility information

## Example

A simple example to do things:

```lua
local moonshine = require("moonshine")

-- TODO
```

## Reference

For a full reference of the API, see [the reference](/docs/reference.md).

## Installation

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
