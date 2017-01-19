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
  
  local spoopySprite = display.newImage( atlas.spoopySheet, 1)
  spoopySprite.y = display.contentCenterY * 0.5
  spoopySprite.x = display.contentCenterX * 0.5
  
  local function move_spoopy( event )
  
    local t = event.time * 0.02
    local randoNumX = math.random(display.contentWidth)
    local randoNumY = math.random(display.contentHeight)
    
    local move_params =
    {
      x = murder_children.x,
      y = murder_children.y,
      delay = 100,
      time = 1000,
      transition = easing.linear,
      --onComplete = attack_timer,
        --i ate the cookies
    }
  
    spoopySprite.x =  spoopySprite.x + math.cos(t)--spoopySprite.x + 5
    spoopySprite.y =  spoopySprite.y + math.sin(t)
	
    spoopy.x = spoopySprite.x
    spoopy.y = spoopySprite.y
    
    transition.moveTo( spoopySprite,  move_params)
  end
  
  Runtime:addEventListener( "enterFrame", move_spoopy)
  

  local attack_timer = timer.performWithDelay(1000, spoopy_collision, 0)

end

return spoopy