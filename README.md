# moonshine

<a href="https://github.com/f4z3r/moonshine/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/f4z3r/moonshine?link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fmoonshine%2Fblob%2Fmain%2FLICENSE" />
</a>
<!-- <a href="https://github.com/f4z3r/moonshine/releases"> -->
<!--     <img src="https://img.shields.io/github/v/release/f4z3r/moonshine?logo=github&link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fmoonshine%2Freleases" /> -->
<!-- </a> -->
<!-- <a href="https://luarocks.org/modules/f4z3r/moonshine"> -->
<!--     <img src="https://img.shields.io/luarocks/v/f4z3r/moonshine?logo=lua&link=https%3A%2F%2Fluarocks.org%2Fmodules%2Ff4z3r%2Fmoonshine" /> -->
<!-- </a> -->

A library for making CLI applications beautiful.

---

<!--toc:start-->
- [moonshine](#moonshine)
  - [Example](#example)
  - [Reference](#reference)
  - [Installation](#installation)
  - [ANSI256 Color Codes](#ansi256-color-codes)
  - [Development](#development)
<!--toc:end-->

---

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

## ANSI256 Color Codes

To get a list of ANSI color codes run:

```bash
curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/e50a28ec54188d2413518788de6c6367ffcea4f7/print256colours.sh | bash
```

## Development

You can setup a dev environment with the needed Lua version:

```bash
# launch shell with some lua version and the dependencies installed:
nix develop .#lua52
```

and then test with `busted`.
