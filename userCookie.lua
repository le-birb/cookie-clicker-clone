

local composer = require "composer"
local widget = require "widget"

local user_data = require "userData"

local user_cookies = user_data[1]
local user_tap_strength = user_data[2]
local user_souls = user_data[3]
local user_buildings = user_data[10]

--local saveFunctions = require "save.lua"

--local save = saveFunctions.save

local scene = composer.newScene() 


local function cookieTapped(event)

  if event.phase == "ended" then

    user_cookies = user_cookies + 1 
    cookieCount.text = "You have " .. user_cookies .. " cookies!"
    
  end

end


local function update()
  cookieCount.text = "You have " .. user_cookies .. " cookies!"
end
timer.performWithDelay( 100, update, -1 )

local function moveToShop(event)

  if event.phase == "ended" then

    composer.gotoScene( "shop" )

  end

end

function scene:create(event)

  local sceneGroup = self.view

  local cookie = {
    label = "MY cookie",
    onEvent = cookieTapped,
    shape = "circle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.5,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },                  
  }                                                    
  local cookie = widget.newButton(cookieOptions)                                            

  local shopOptions = {
    label = "shop",
    onEvent = moveToShop,
    shape = "rectangle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.8,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },                  
  }
  
  local shopButton = widget.newButton(shopOptions)
  
  --[[local saveButton = {
    label = "save",
    onEvent = save("a_save_file"),
    shape = "rectangle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.65,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },
  }]]--
  
  sceneGroup:insert(shopButton)
  --sceneGroup:insert(saveButton)
  sceneGroup:insert(cookie)
  sceneGroup:insert(cookieCount.text)

end

function scene:show(event)
  
  local sceneGroup = self.view 
  local phase = event.phase 
  
  if phase == "will" then -- Called when the scene is still off screen and is about to move on screen
    
  elseif phase == "did" then -- Called when the scene is now on screen
    
  end
  
end

function scene:hide( event )
  local sceneGroup = self.view 
  local phase = event.phase
  
  if phase == "will" then -- Called when the scene is on screen and is about to move off screen

  elseif phase == "did" then -- Called when the scene is now off screen

  end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene