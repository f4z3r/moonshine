# moonshine

<a name="top"></a>

<!--toc:start-->
- [moonshine](#moonshine)
  - [Spinners](#spinners)
    - [wrap](#wrap)
<!--toc:end-->

---

## Spinners

### wrap

```lua
(method) wrap(func, text: string, symbols?: string[], interval?: number, width?: number)
  -> ...
```

Wrap a function in a spinner. This will print a spinner to standard output for the duration of the
execution of the function that it wraps.

Parameters:
- `func` — The function that is being wrapped. This function takes a single argument: a linda which
  allows to update the text being displayed next to the spinner.
- `text` — The initial text to display next to the spinner.
- `symbols` — The symbols table to use for the spinner. If none is provided,
  `SPINNERS.ROTATING_DOTS` will be used.
- `interval` — The interval in milliseconds to update the spinner. By default 100ms.
- `width` — The maximum width the spinner should have in the terminal. By default 80 characters.

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
