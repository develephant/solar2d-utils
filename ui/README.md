# UI

## Button

### Options

|Option|Type|Default|
|------|----|-------|
|`x`|Int|`contentCenterX`|
|`y`|Int|`contentCenterY`|
|`width`|Int|`120`|
|`height`|Int|`60`|
|`label`|String|"button"|
|`labelAlign`|String|"center"|
|`labelColor`|Object|`{default={1,1,1}, over={0,0,0,0.5}}`|
|`fontSize`|Int|`18`|
|`shape`|String|"roundedRect"|
|`fillColor`|Object|`{default={1,1,1}, over={0,0.5,1}}`|
|`strokeColor`|Object|`{default={0,0,0}, over={0,0,0}}`|
|`strokeWidth`|Int|`0`|
|`cornerRadius`|Int|`0`|
|`isEnabled`|Bool|`true`|
|`id`|String|"button"|
|`onPress`|Event|`nil`|
|`onRelease`|Event|`nil`|
|`onEvent`|Event|`nil`|

### Usage

```lua
local Button = require('button')

local submitBtn = Button.new({
    x = 100,
    y = 100,
    label = 'Submit'
})
```

---

## Text

### Options

|Option|Type|Default|
|------|----|-------|
|`text`|String|"text"|
|`x`|Int|`contentCenterX`|
|`y`|Int|`contentCenterY`|
|`width`|Int|`200`|
|`height`|Int|`0`|
|`font`|String/Constant|`systemFont`|
|`fontSize`|Int|`24`|
|`align`|String|"center"|
|`parent`|Object|`nil`|

### Usage

```lua
local Text = require('text')

local TitleText = Text.new({
    text = "Title",
    x = 100,
    y = 200
})

```