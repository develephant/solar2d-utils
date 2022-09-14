--#############################################################################
--# Text
--#############################################################################
local defaultTextColor = {1, 1, 1}

local _M = {}
_M.VERSION = "0.0.1"

function _M.new(options)
  options = options or {}

  local txtObj = display.newText({
    parent = options.parent,
    text = options.text or "text",
    x = options.x or display.contentCenterX,
    y = options.y or display.contentCenterY,
    width = options.width or 200,
    height = options.height or 0,
    font = options.font or native.systemFont,
    fontSize = options.fontSize or 24,
    align = options.align or "center"
  })

  local h, s, b = unpack(options.color or defaultTextColor)

  txtObj:setFillColor(h, s, b)

  return txtObj
end

return _M