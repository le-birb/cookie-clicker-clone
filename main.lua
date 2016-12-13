
local composer = require "composer" 
local widget = require "widget"
local lfs = require "lfs"
local native = require "native"

local scene = composer.newScene() 

local user_data = require "user_data"

local load_file = user_data.load

--[[temporary error prevention for testing
user_data.cookies = 0
user_data.cookie_tap = 10
user_data.cps = 0
user_data[4] = 0

-- this function handles the event for when and/or if the button is pressed
local function handleCookieBtn(event)

  if event.phase == "ended" then -- this event.phase == "ended" means that the button was tapped, then the users finger left the button

    print("cookieBtn was pressed!") 

    display.remove(cookieBtn) 
    composer.gotoScene( "user_cookie" ) 

  end

end


local options = {
  left = 80, 
  top = 100, 
  label = "Visit Your Cookie!", 
  onEvent = handleCookieBtn 
}


cookieBtn = widget.newButton(options) -- this will display the button with the parameters 'options'
]]--

local function new_game()
  
  name_prompt = display.newImageRect("box.png", "resources", 56, 32)
  
  name_prompt.x = dislay.contentCenterX
  name_prompt.y = display.contentCenterY
  
  local text_options = {
    text = "What would you like to name your file?",
    x = display.contentCenterX,
    y = display.contentCenterY + 10,
    width = 48,
    height = 0,
    font = native.systemFont,
  }
  
  local button_options = {
    label = "Enter",
    x = display.contentCenterX,
    y = display.contentCenterY - 20,
    width = 48,
    height = 24,
    onEvent = function() 
      
    end
  }
  
  name_prompt_text = display.newText(text_options)
  
  name_prompt_input = native.newTextField(display.contentCenterX, display.contentCenterY, 48, 10)
  
  load_file("new_game")
  
  user_data.save(name)
  
  composer.gotoScene("user_cookie")
  
end

local function make_file_buttons() 
  
  --first create a scroll content container in which to store the buttons
  local file_viewer_options = {
    id = "file_buttons",
    left = display.contentWidth * .1,
    top = display.contentHeight * .1,
    width = display.contentWidth * .8,
    height = display.contentHeight * .75,
    horizontalScrollDisabled = true,
    --visuals and stuff are yet to be added and will go here
    --that would be background visuals
  }
  
  local file_viewer = widget.newScrollView(file_viewer_options)
  
  --this creates an iterator which iterates through each file in a directory
  for file in lfs.dir("saves/") do
    
    if file ~= "new_game" then  
      --create a button for each file in the directory
      local file_button_options = {
        width = display.contentWidth * .85,
        height = display.contentHeight * .85,
        label = file,
        --when the button is pressed, load the corresponding file and begin the game
        onEvent = function ()
          load_file(file)
          composer.gotoScene("user_cookie")
        end,
        fillColor = { default = {24/255,55/255,0/255,1} }
      }
    end
    
  local file_button = widget.newButton(file_button_options)
  
  file_viewer:insert(file_button)
  
  end
  
end

make_file_buttons()

--new game button
local ng_button_options = {
  label = "New Game",
  width = display.contentWidth * .8,
  height = display.contentHeight *.1,
  left = display.contentWidth * .15,
  top = display.contentHeight * .9,
  onEvent = new_game,
  fillColor = { default = {24/255,55/255,0/255,1} },
}

ng_button = widget.newButton(ng_button_options)
