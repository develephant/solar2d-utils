--#############################################################################
--# Button
--#############################################################################
local widget = require("widget")

local _M = {}
_M.VERSION = "0.0.1"

-- Button Defaults
local BTN = {
  WIDTH = 120,
  HEIGHT = 60,
  FONT_SIZE = 18,
  DEFAULT_NAME = "button"
}

-- Color Defaults
local COLORS = {
  BLUE = {0.013, 0.65, 1},
  LITE_BLUE = {0.40, 0.77, 1},
  DARK_BLUE = {0, 0.50, 1},
  WHITE = {1, 1, 1},
  BLACK = {0, 0, 0}
}

--#############################################################################

function _M.new(options)
  options = options or {}

  options.shape = options.shape or "roundedRect"
  if options.shape == "roundedRect" then
    options.radius = options.radius or 5
  end

  local btn = widget.newButton({
    id = options.id or BTN.DEFAULT_NAME,
    width = options.width or BTN.WIDTH,
    height = options.height or BTN.HEIGHT,
    label = options.label or "button",
    labelAlign = options.align or "center",
    labelColor = { default=(options.color or COLORS.WHITE), over=(options.overColor or {0, 0, 0, 0.5}) },
    fontSize = options.fontSize or BTN.FONT_SIZE,
    shape = options.shape or "roundedRect",
    fillColor = { default=(options.fillColor or COLORS.LITE_BLUE), over=(options.overFill or COLORS.DARK_BLUE)},
    strokeColor = { default=(options.strokeColor or COLORS.BLACK), over=(options.overStroke or COLORS.BLACK)},
    strokeWidth = options.strokeWidth or 0,
    cornerRadius = options.radius or 0,
    x = options.x or display.contentCenterX,
    y = options.y or display.contentCenterY,
    isEnabled = options.enabled or true,
    onPress = options.onPress,
    onRelease = options.onRelease,
    onEvent = options.onEvent
  })

  return btn
end

return _M