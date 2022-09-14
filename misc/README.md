# Utils

## bind

```lua
local utils = require('utils')

local function onSomething(part1, part2)
    print(part1, part2)
end

events.addEventListener('doSomething', utils.bind(onSomething, self, 'p1', 'p2'))


```

### Usage

```lua
...

function _M.onResult(res)

end

events.addEventListener('on-result', utils.bind(onResult, self))

```


---

## pp

_Pretty print a table structure._

```lua
local utils = require('utils')

local t = {
    name = "Jim",
    age = "50"
}

utils.pp(t)
```