-- REQUIRES Alignmate (https://github.com/develephant/solar2d-alignmate-lib)

local Text = require('ui.text')
local Button = require('ui.button')
local Alignmate = require('alignment.alignmate')

local TitleText = Text.new({ text = "Jello", fontSize = 48 })
local HelloText = Text.new({ text = "Hello", fontSize = 48 })
local MellowText = Text.new({ text = "Mellow", fontSize = 48 })

Alignmate.center(TitleText)
Alignmate.centerRight(HelloText)
Alignmate.centerLeft(MellowText)

local function onSubmit(e)
    print('clicked')
    TitleText.text = "Swello"
end

local submitButton = Button.new({ 
    label = "Submit",
    onPress = onSubmit 
})

Alignmate.bottom(submitButton, { padBottom = 20 })