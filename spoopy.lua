local math = require "math"
local murder_children = require "murder_children"
--local user_cookie = require "user_cookie"

local has_MCs = false

local playerHasSpoopy = false

local spoopy_functions = {}

function spoopy_spawn()


  --[[local spoopy_stats = 
  {
    "power" = 1,
    "movement" = 1 --TODO
  }]]--
  
  local spoopy_options =
  {
    frames =
    {
      { -- frame 1
        x = 0,
        y = 0,
        width = 20,
        height = 26
      }--[[,
      { -- frame 2
        x = 16,
        y = 0,
        width = 16,
        height = 26  
      } ]]--
    }
  
  }
  
  local spoopySheet = graphics.newImageSheet("resources/spoopyer.png", spoopy_options)
    
  
  local spoopySprite = display.newImage( spoopySheet, 1)
  spoopySprite.y = display.contentCenterY * 0.5
  spoopySprite.x = display.contentCenterX * 0.5
  
  
  local function move_spoopy( event )
  
    local t = event.time * 0.02
    local randoNumX = math.random(display.contentWidth)
    local randoNumY = math.random(display.contentHeight)
    
    local move_params =
    {
		--x = mcList[1].x,
		--y = mcList[1].y,
      x = randoNumX,
      y = randoNumY,
      delay = math.random(1000, 10000),
      time = math.random(3000, 5000),
      transition = easing.inOutQuad
      --i ate the cookies
    }
  
    --spoopySprite.x =  spoopySprite.x + math.cos(t)--spoopySprite.x + 5
    spoopySprite.y =  spoopySprite.y + math.sin(t)

    transition.moveTo( spoopySprite,  move_params)
  end
  
  Runtime:addEventListener( "enterFrame", move_spoopy)
  

end

return spoopy_spawn()