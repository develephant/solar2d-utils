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

function _M.new( options )
  options = options or {}

  options.defaultDir = options.default_dir or system.DocumentsDirectory

  return setmetatable( options, mt)
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

return _M