# Filesystem

Filesystem helper.

## Methods

- `split(input_str, separtator)`
- `trim(str)`
- `normalize(path, sep)`
- `join(...)`
- `basename(path)`
- `extension(file)`
- `filename(file)`
- `getPath(path[, dir])`
- `fileExists(path)`
- `isDir(path)`
- `isFile(path)`
- `listDir(dirpath)`
- `isDirEmpty(dirpath)`
- `loadFile(path)`
- `saveFile(path, data)`
- `deleteFile(path)`
- `copyBinaryFile(source, destination)`
- `makeDocumentsDir(dir_name)`
- `getEnvironment`
- `isSim`
- `getPlatform`
- `isMacOS`
- `isWin32`
- `getPathSeparator`


## Options

- `defaultDirectory`

## Usage

```lua
local fs = require('fs')

local FileSystem = fs.new()

local path = FileSystem:getPath('taco.png')
```

