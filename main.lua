
local composer = require "composer" 
local widget = require "widget"

local user_data = require "userData"

local load_save = user_data.load

--temporary error prevention for testing
user_data[1] = 0
user_data[2] = 10
user_data[3] = 0

-- this function handles the event for when and/or if the button is pressed
local function handleCookieBtn(event)

  if event.phase == "ended" then -- this event.phase == "ended" means that the button was tapped, then the users finger left the button

    print("cookieBtn was pressed!") 

    display.remove(cookieBtn) 
    composer.gotoScene( "userCookie" ) 

  end

end


local options = {
  left = 80, 
  top = 100, 
  label = "Visit Your Cookie!", 
  onEvent = handleCookieBtn 
}


cookieBtn = widget.newButton(options) -- this will display the button with the parameters 'options'

local function newGame(name)
  
  load_save("new_game")
  
  user_data.save(name)
  
end
