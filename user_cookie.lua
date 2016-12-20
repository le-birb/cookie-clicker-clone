
local composer = require "composer"
local widget = require "widget"
local atlas = require "atlas"

local user_data = require "user_data"
local spoopy = require "spoopy"
local murder_children = require "murder_children"
local scene = composer.newScene() 

mcList = {}
local has_MCs = false
local paused = false

local cookie_count_text

local function cookieTapped(event)

  if event.phase == "ended" then

    user_data.cookies = user_data.cookies + 1 
    cookie_count_text.text = "You have " .. user_data.cookies .. " cookies!"
    
  end

end


local function update()
  cookie_count_text.text = "You have " .. user_data.cookies .. " cookies!"
end
timer.performWithDelay( 100, update, -1 )

local function moveToShop(event)

  if event.phase == "ended" then

    composer.gotoScene( "shop" )

  end

end

function scene:create(event)

  local scene_group = self.view
  
    local spriteOptions =
  {  
    frames =
    {
      { -- frame 1
        x = 0,
        y = 0,
        width = 180,
        height = 181
      },
      { -- frame 2
        x = 180,
        y = 0,
        width = 180,
        height = 181  
      }
    
    }
    
  }
  
  local cookieSheet = graphics.newImageSheet( "resources/PHCookie.png.png", spriteOptions)
  
  local cookieSheetOptions = 
  {
    onEvent = cookieTapped,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.5,
    sheet = cookieSheet,
    defaultFrame = 1,
    overFrame = 2
  }
  
  local cookie = widget.newButton(cookieSheetOptions)                                    

  --[[local shOPtions = {
    label = "shop",
    onEvent = moveToShop,
    shape = "rectangle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.8,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },                  
  }
  
  local shopButton = widget.newButton(shOPtions)]]--
  
  local cookie_count_text_options = {
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.2,
    text = "You have " .. user_data.cookies .. " cookies!"
  }
  
  cookie_count_text = display.newText(cookie_count_text_options)
  
  --[[local saveButton = {
    label = "save",
    onEvent = save("a_save_file"),
    shape = "rectangle",
    width = 200,
    x = display.contentWidth * 0.5,
    y = display.contentHeight * 0.65,
    fillColor = { default = {24/255,55/255,0/255,1}, over = {66/255,0/255,23/255,1} },
  }]]--
  
  --scene_group:insert(shopButton)
  --scene_group:insert(saveButton)
  scene_group:insert(cookie)
  scene_group:insert(cookie_count_text)
  
  print("doing thing")

  spoopy.spoopy_spawn()

  local function spawnMC()
  
  --max. is 10 on-screen; if the count exceeds that amount stop spawning, else spawn one
	if(murder_children.mc_count < 10) then  
	
		mcList[#mcList+1] = murder_children.new("basic", 3, 1, .34, easing.linear, 
		atlas.basic_mc_sheet, atlas.sequences_basicMC)
		murder_children.mc_count = murder_children.mc_count + 1 
		
	end
	
  
  end
  
  spawn_timer = timer.performWithDelay(5000, spawnMC, 0)

end

function scene:show(event)
  
  local scene_group = self.view 
  local phase = event.phase 
  
  if phase == "will" then -- Called when the scene is still off screen and is about to move on screen
    
  elseif phase == "did" then -- Called when the scene is now on screen
    
  end
  
end

function scene:hide( event )
  local scene_group = self.view 
  local phase = event.phase
  
  if phase == "will" then -- Called when the scene is on screen and is about to move off screen

  elseif phase == "did" then -- Called when the scene is now off screen

  end
end

--timer.performWithDelay(.01, user_data.cps_tick, -1)

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

