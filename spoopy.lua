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
  
  local function hasCollided()
    
    if spoopySprite == nil then 
      return false
    end

    local dx = spoopySprite.x - murder_children.x
    local dy = spoopySprite.y - murder_children.y
      
    local distance = math.sqrt( dx*dx + dy*dy )
		local objectSize = murder_children.x/2 + spoopySprite.x/2 
      
    if distance < objectSize then	
      return true
		end
    return false
    
  end
    
  local function kill()
  
	if hasCollided() == true and murder_children.HP > 0 then
		murder_children.HP = murder_children.HP - 1
		print(murder_children.HP)
		--murder_children.isDead = false
	end
	if murder_children.HP <=0 then
		murder_children.kill(murder_children.sprite)
		murder_children.sprite = nil
		murder_children.isDead = true
	end
		
  end
  
  kill_timer = timer.performWithDelay(2000, kill, 0)

	
  

end

return spoopy