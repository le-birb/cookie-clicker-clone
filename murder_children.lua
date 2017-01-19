
local atlas = require "atlas"
local math = require "math"
local user_data = require "user_data"

local murder_children = {}
local mc_table = { __index = murder_children }

murder_children.mc_count = 0
murder_children.x = 0
murder_children.y = 0
murder_children.HP = 0
murder_children.sprite = nil
murder_children.soul_reward = 0

murder_children.has_spoopy = false



function murder_children.new(n_type, n_health, n_soul_reward, n_cps_eaten, n_move_func, sprite_obj, frames)

	local new_child = {}
	mc_type = n_type
	murder_children.HP = n_health
	murder_children.soul_reward = n_soul_reward
	cps_eaten = n_cps_eaten
	move_func = n_move_func
	new_child.image = display.newSprite(sprite_obj, frames)
	new_child.image:play()
	
	local spawnX = 0
	local spawnY = 0

  --RNG used to spawn MC top(1), left(0), right(3), or bottom(4) of screen--
	local spawn_RNG = math.random(1, 4)
	if spawn_RNG == 1 then
		spawnX = 0
		spawnY = math.random(display.contentHeight)
	elseif spawn_RNG == 2 then	
		spawnX = math.random(display.contentWidth)
		spawnY = 0
	elseif spawn_RNG == 3 then
		spawnX = display.contentWidth
		spawnY = math.random(display.contentHeight)
	else
		spawnX = math.random(display.contentWidth)
		spawnY = display.contentHeight
	end	
	new_child.image.x = spawnX
	new_child.image.y = spawnY
	
	murder_children.sprite = new_child.image
	
	--cookie boundary
	local cookie_coordX_RNG = math.random(display.contentHeight*0.25, display.contentHeight*0.5)
	local cookie_coordY_RNG = math.random(display.contentWidth*0.40, display.contentWidth*0.75)
  
  --MCs spawn around border and move to a random point on the cookie
	local function move_MC( event )
	
		local t = event.time * 0.05
		
		local move_params =
		{
			x = cookie_coordX_RNG,
			y = cookie_coordY_RNG,
			time = math.random(3000, 5000),
			transition = move_func,
      onComplete = function() user_data.cps = user_data.cps - cps_eaten end
		}
		
		if new_child.image ~= nil then
			transition.moveTo(new_child.image, move_params)
			
			murder_children.x = new_child.image.x
			murder_children.y = new_child.image.y
		end
	end
	
	Runtime:addEventListener( "enterFrame", move_MC)
	
	--check if the MC has collided with the cookie
  	local function hasCollided()
  	    
	    --make sure the image exists first
		if new_child.image == nil or new_child.image.width == nil then	
			return false
		end	
	 
		local dx = new_child.image.x - 160
		local dy = new_child.image.y - 160
	 
		local distance = math.sqrt( dx*dx + dy*dy )
		local objectSize = 80 + (new_child.image.width/2)
	 
		if distance < objectSize then	
			return true
		end
		return false
		
   end
   
   --if the MC has collided with the cookie, begin depleting cookies
   local function eat()		
		if hasCollided() == true and user_data.cookies > 0 then
				user_data.cookies = user_data.cookies - 1	
		end
   end
   
   eat_timer = timer.performWithDelay(cps_eaten, eat, 0)
		
	
	local function mc_touch( event )
		if event.phase == "ended" and murder_children.HP > 0 then	
			murder_children.HP = murder_children.HP - 1

			print("tapped!")
		end	
		if(murder_children.HP <= 0) then
			print("murdered!")
      user_data.cps = user_data.cps + cps_eaten
			transition.fadeOut( new_child.image, {time = 1000})
			display.remove( new_child.image )
			user_data.souls = user_data.souls + murder_children.soul_reward
			murder_children.mc_count = murder_children.mc_count - 1 

		end	
	end
	new_child.image:addEventListener( "touch", mc_touch)


	
	return setmetatable (new_child, mc_table)
	
end

function murder_children.kill( sprite )

	local function removeSprite()
		timer.performWithDelay(150, function() display.remove(sprite)end)
	end

	if sprite ~= nil then
		transition.to(sprite, {
		time = 150, 
		alpha = 0,
		onComplete = removeSprite()})
	end
	user_data.souls = user_data.souls + murder_children.soul_reward
	murder_children.mc_count = murder_children.mc_count - 1 
	print("murdered!")
end



return murder_children
	