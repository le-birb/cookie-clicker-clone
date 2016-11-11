

local composer = require("composer")
local widget = require("widget")

local user_data = require("userData")

local user_cookies = user_data[1]
local user_tap_strength = user_data[2]
local user_buildings = user_data[3]

local scene = composer.newScene()

local function moveToCookie(event)

  if event.phase == "ended" then

    composer.gotoScene( "userCookie" )

  end

end


function scene:create(event)

  local sceneGroup = self.view

  local intro = display.newText("Cookie Shop", display.contentWidth * 0.5, display.contentHeight * 0.1, native.systemFontBold, 30)
  local returnOptions = {
    label = "go to cookie!",
    onEvent = moveToCookie,
    shape = "rectangle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.8,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },
  }
  local returnToCookie = widget.newButton(returnOptions)


  sceneGroup:insert(intro)
  sceneGroup:insert(returnToCookie)
  sceneGroup:insert(cookieFarm)
  sceneGroup:insert(cookiePlantation)
end

function scene:show(event)

  local sceneGroup = self.view

end

function scene:hide(event)

  local sceneGroup = self.view



end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene
