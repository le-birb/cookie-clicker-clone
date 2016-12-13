local math = require "math"
local atlas = require "atlas"
local murder_children = require "murder_children"
local user_data = require "user_data"
--local user_cookie = require "user_cookie"

local spoopy = {}

local playerHasSpoopy = false

spoopy.x = 0
spoopy.y = 0


function spoopy.spoopy_spawn()


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
  
    spoopySprite.x =  spoopySprite.x + math.cos(t)--spoopySprite.x + 5
    spoopySprite.y =  spoopySprite.y + math.sin(t)
	
	spoopy.x = spoopySprite.x
	spoopy.y = spoopySprite.y
	

    transition.moveTo( spoopySprite,  move_params)
  end
  
  Runtime:addEventListener( "enterFrame", move_spoopy)
  
  local function spoopy_collision( obj )
	
	if(murder_children.HP > 0) then
		murder_children.HP = murder_children.HP - 1
		print(murder_children.HP)
	end
  end
  
  local attack_timer = timer.performWithDelay(1000, spoopy_collision, 0)

end

return spoopy