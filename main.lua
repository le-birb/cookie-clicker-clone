--local composer = require "composer"

--composer.gotoScene("main_menu")


local composer = require "composer"
local widget = require "widget" 
local user_data = require "user_data"


local function handleCookieBtn(event)

  if event.phase == "ended" then 
    user_data.cookies = 0
    user_data.cookie_tap = 0
    user_data.souls = 0
    user_data.cps = .0000001
    display.remove(cookieBtn) 
    composer.gotoScene( "user_cookie" ) 
  end

end


local options = {
  left = 80, 
  top = 100, 
  label = "New Game", 
  onEvent = handleCookieBtn 
}


cookieBtn = widget.newButton(options)