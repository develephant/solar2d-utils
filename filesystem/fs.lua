--#############################################################################
--# FS Utils
--#############################################################################
local io = require("io")
local os = require("os")
local lfs = require("lfs")

local _M = {}

local mt = { __index = _M }

_M.DOCUMENTS_DIR = system.DocumentsDirectory
_M.RESOURCES_DIR = system.ResourceDirectory
_M.TEMP_DIR = system.TemporaryDirectory

_M.MACOS = "macos"
_M.WIN32 = "win32"

--alias
_M.sep = _M.getPathSeparator

function _M.new( options )
  options = options or {}
  options.defaultDir = options.default_dir or system.DocumentsDirectory
  options.sep  = _M.getPathSeparator
  return setmetatable( options, mt)
end

--##############################################################################
-- Paths
--##############################################################################
function _M.split(self, inputstr, sep_token)
  if sep_token == nil then
    sep_token = "%s"
  end
  local t = {}
  local i = 1
  for str in string.gmatch(inputstr, "([^" .. sep_token .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function _M.trim(self, str)
  return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

function _M.normalize(self, path, sep)
  sep = sep or self.sep()
  return (string.gsub(path, "%"..sep.."+", sep))
end

function _M.join( self, ... )
  local paths = { ... }
  local sep = self.sep()
  return _M.normalize(table.concat( paths, sep ))
end

function _M.basename( self, path )
  path = _M.normalize(path)
  local parts = _M.split(path, self.sep())
  return table.remove(parts)
end

--file extension
function _M.extension(self, file)
  return self.split(self, file, '.')[2]
end

--filename sans extension
function _M.filename(self, file)
  return self.split(self, file, '.')[1]
end

function _M.getPath(self, path, dir)
  dir = dir or self.defaultDir
  return system.pathForFile(path, dir)
end

function _M.fileExists(self, path)
  local fd, err = io.open(self:getPath(path), 'r')
  if not fd then
    return false
  end
  fd:close()
  return true
end

function _M.isDir( self, path )
  local res, err = lfs.attributes(path, "mode")
  if not res then
    return nil, err
  end
  if res == "directory" then
    return true
  end
  return nil, 'directory not found.'
end

function _M.isFile( self, path )
  local res, err = lfs.attributes(path, "mode")
  if not res then
    return nil, err
  end
  if res == "file" then
    return true
  end
  return nil, 'file not found.'
end

--list directory
function _M.listDir(self, dirpath)
  local list = {}
  for file in lfs.dir(dirpath) do
    if file ~= "." and file ~= ".." then
      if not fs.isDir(dirpath.."/"..file) then
        table.insert(list, file)
      end
    end
  end
  return list
end

--is empty directory
function _M.isDirEmpty(self, dirpath)
  local list = {}
  for file in lfs.dir(dirpath) do
    if file ~= "." and file ~= ".." then
      table.insert(list, file)
    end
  end
  if #list == 0 then
    return true
  end
  return false
end

-- Solar2d specific
function _M.getRootDirectory(self)
  local root = system.pathForFile("build.settings")
  local parts = self:split(root, self:sep())
  local _ = table.remove(parts)
  local root_path = table.concat(parts, "\\")
  return root_path
end

--##############################################################################
-- Files
--##############################################################################
function _M.loadFile(self, path)
  local fd, err = io.open(self:getPath(path), 'r')
  if not fd then
    return nil, err
  end

  local data = fd:read("*a")
  fd:close()

  if not data then
    return nil, "Could not read "..path
  end

  return data
end

function _M.saveFile(self, path, data)
  local fd, err = io.open(self:getPath(path), 'w')
  if not fd then
    return nil, err
  end

  fd:write(data)
  fd:close()

  return true
end

function _M.copyBinaryFile(self, source, destination)

  local fd, err = io.open(source, 'rb')
  if not fd then
    return nil, "Source file not found."
  end

  local data = fd:read("*a")

  if not data then
    return nil, "Could not read binary data."
  end

  fd:close()

  local fd, err = io.open(destination, 'wb')
  if not fd then
    return nil, "Could not find destination file"
  end

  fd:write(data)
  fd:close()

  return true

end

function _M.deleteFile(self, path)
  local ok, err = os.remove(self:getPath(path))
  if not ok then
    return nil, err
  end

  return true
end

function _M.makeDocumentsDir(self, dir_name)
  local docs_path = system.pathForFile("", self.DOCUMENTS_DIR)
  local success = lfs.chdir( docs_path )
  if success then
    lfs.mkdir( dir_name )
    return lfs.currentdir() .. "/" .. dir_name
  else
    return nil, "could not create directory."
  end
end

--##############################################################################
-- Device
--##############################################################################
function _M.getEnvironment(self)
  return system.getInfo("environment")
end

function _M.isSim(self)
  if self:getEnvironment() == "simulator" then
    return true
  end

  return false
end

function _M.getPlatform(self)
  local platform = system.getInfo("platform")
  if platform == self.WIN32 then
    return self.WIN32
  elseif platform  == self.MACOS then
    return self.MACOS
  else
    return false
  end
end

function _M.isMACOS(self)
  if self:getPlatform() == self.MACOS then
    return true
  end
end

function _M.isWIN32(self)
  if self:getPlatform() == self.WIN32 then
    return true
  end
end

function _M.getPathSeparator(self)
  if self:isMACOS() then
    return [[/]]
  elseif self:isWIN32() then
    return [[\]]
  else
    return [[/]]
  end
end

return _M