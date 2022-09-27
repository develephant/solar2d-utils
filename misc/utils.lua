--#############################################################################
--# Utils
--#############################################################################
local _M = {}

--#############################################################################
--# Binding
--#############################################################################
function _M.bind(fn, self, ...)
  return function(...)
    return fn(self, ...)
  end
end

--##############################################################################
-- Hex
--##############################################################################
function _M.hexdecode(hex)
  return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end

function _M.hexencode(str)
  return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end

--#############################################################################
--# Pretty Print
--#############################################################################
function _M.pp( t, indent )
  if not t and type( t ) ~= 'table' then
    return nil, "Please provide a valid table"
  end

  local names = {}
  if not indent then indent = "" end
  for n,g in pairs(t) do
      table.insert(names,n)
  end
  table.sort(names)
  for i,n in pairs(names) do
      local v = t[n]
      if type(v) == "table" then
          if(v==t) then -- prevent endless loop if table contains reference to itself
              print(indent..tostring(n)..": <-")
          else
              print(indent..tostring(n)..":")
              _M.pp(v,indent.."   ")
          end
      else
          if type(v) == "function" then
              print(indent..tostring(n).."()")
          else
              print(indent..tostring(n)..": "..tostring(v))
          end
      end
  end
end

return _M