local composer = require "composer"

--composer.gotoScene("main_menu")


local composer = require "composer"
local widget = require "widget" 
local userData = require "userData"


local function handleCookieBtn(event)

  if event.phase == "ended" then 
    display.remove(cookieBtn) 
    composer.gotoScene( "userCookie" ) 
  end

end


local options = {
  left = 80, 
  top = 100, 
  label = "New Game", 
  onEvent = handleCookieBtn 
}


cookieBtn = widget.newButton(options)