# moonshine

<a name="top"></a>

<!--toc:start-->
- [moonshine](#moonshine)
  - [Spinners](#spinners)
    - [wrap](#wrap)
      - [Example](#example)
    - [SPINNERS](#spinners-1)
  - [Prompts](#prompts)
    - [get_input](#getinput)
      - [Example](#example-1)
    - [get_pass](#getpass)
      - [Example](#example-2)
    - [confirm](#confirm)
      - [Example](#example-3)
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

## Prompts

### get_input

```lua
(method) get_input(prompt: string, fh?)
  -> string
```

Get input from the command line. This will print a prompt to the provided file handler or stderr by
default, and return the input provided by the user when enter is pressed.

Parameters:
- `prompt` — The prompt to print. This will get a space concatenated at the end.
- `fh` — The file handle to which to write the prompt. By default print to `io.stderr`.

#### Example

```lua
local prompt = require("moonshine.prompt")

local string = require("string")

local input = prompt.get_input("Get some standard input:")
print(string.format("You entered '%s'", input))
```

For more examples, see [`examples/prompt.lua`](./../examples/prompt.lua).

[Back to top](#top)

### get_pass

```lua
(method) get_pass(prompt: string, fh?)
  -> string
```

Prompt the user for a password without echoing. The user is prompted using the prompt string, which
is printed to the provided file handler, which defaults to `io.stderr`.

Parameters:
- `prompt` — The prompt to print. This will get a space concatenated at the end.
- `fh` — The file handle to which to write the prompt. By default print to `io.stderr`.

#### Example

```lua
local prompt = require("moonshine.prompt")

local string = require("string")

local password = prompt.get_pass("Enter something secret:")
print(string.format("You entered a password of lenght %d", #password))
```

For more examples, see [`examples/prompt.lua`](./../examples/prompt.lua).

[Back to top](#top)

### confirm

```lua
(method) confirm(prompt: string, fh?)
  -> boolean
```

Prompt the user to confirm based on the provided prompt string. The prompt is printed to the
provided file handle, which defaults to `io.sterr`. This returns whether the user confirmed or not.

Parameters:
- `prompt` — The prompt to print. The ` (y/N)?` suffix will automatically be added.
- `fh` — The file handle to which to write the prompt. By default print to `io.stderr`.

#### Example

```lua
local prompt = require("moonshine.prompt")

local string = require("string")

while not prompt.confirm("Should we exit") do
  print("Let's try again")
end
```

For more examples, see [`examples/prompt.lua`](./../examples/prompt.lua).

[Back to top](#top)
