# moonshine

<a name="top"></a>

<!--toc:start-->
- [moonshine](#moonshine)
  - [Spinners](#spinners)
    - [wrap](#wrap)
      - [Example](#example)
    - [SPINNERS](#spinners)
<!--toc:end-->

---

## Spinners

### wrap

```lua
(method) wrap(func, text: string, symbols?: string[], interval?: number)
  -> ...
```

Wrap a function in a spinner. This will print a spinner to standard output for the duration of the
execution of the function that it wraps.

Parameters:
- `func` — The function that is being wrapped. This function takes a single argument: a linda which
  allows to update the text being displayed next to the spinner. The `"update"` key is used to
  update the text.
- `text` — The initial text to display next to the spinner.
- `symbols` — The symbols table to use for the spinner. If none is provided,
  `SPINNERS.ROTATING_DOTS` will be used.
- `interval` — The interval in milliseconds to update the spinner. By default 100ms.

#### Example

```lua
local spinner = require("moonshine.spinner")

local os = require("os")

local a, b = spinner.wrap(function(linda)
  os.execute("sleep 2s")
  -- update text from initial "waiting..." to "still waiting..."
  linda:send("update", "still waiting...")
  os.execute("sleep 2s")
  return 1, 2
end, "waiting...", spinners)

assert(a == 1, "a should be 1")
assert(b == 2, "b should be 2")
```

For more examples, see [`examples/spinner.lua`](./../examples/spinner.lua).

[Back to top](#top)

---

### SPINNERS


A set of possible spinners to use:

```lua
{
  ROTATING_DOTS = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  ROTATING_LINE = { "|", "/", "-", "\\" },
  MOVING_DOTS = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●" },
  ELLIPSIS = { "   ", ".  ", ".. ", "..." },
}
```

[Back to top](#top)
