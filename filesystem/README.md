# Filesystem

Filesystem helper.

## Methods

- `getPath(path[, dir])`
- `fileExists(path)`
- `loadFile(path)`
- `saveFile(path, data)`
- `deleteFile(path)`
- `copyBinaryFile(source, destination)`
- `makeDocumentsDir(dir_name)`

## Options

- `defaultDirectory`

## Usage

```lua
local fs = require('fs')

local FileSystem = fs.new()

local path = FileSystem:getPath('taco.png')
```

