

local composer = require("composer")
local widget = require("widget")

local user_data = require("user_data")

local scene = composer.newScene()

local function moveToCookie(event)

  if event.phase == "ended" then

    composer.gotoScene( "user_cookie" )

  end

end


function scene:create(event)

  local scene_group = self.view

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


  scene_group:insert(intro)
  scene_group:insert(returnToCookie)
end

function scene:show(event)

  local scene_group = self.view

end

function scene:hide(event)

  local scene_group = self.view



end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene
