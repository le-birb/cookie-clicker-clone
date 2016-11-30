local math = require "math"
local MC_sprite_options = require "MC_sprite_options"
--types: basic, super, sneaky, fat, 

local MC_spawnTable = {}

local murder_children = {type = "", health = 0, soul_reward = 1, cps_eaten = 0}
local mc_mt = {__index = murder_children}

function murder_children:new(n_type, n_health, n_soul_reward, n_cps_eaten, n_move_func, sprite_obj)
  
  new_child = {
  
    type = n_type, 
    health = n_health, 
    soul_reward = n_soul_reward, 
    cps_eaten = n_cps_eaten,
    move = n_move_func,
    sprite = sprite_obj
    
  }
  self = mc_mt
  return setmetatable(new_child, self)
  --[[__index = self
  setmetatable(new_child, self)

  return new_child 
  ]]--
end

function murder_children:spawn()

  --RNG used to spawn MC top, left, right, or bottom of screen--
	local spawn_RNG = math.random(1, 4)
	if spawn_RNG == 1 then
		self.sprite.x = 0
		self.sprite.y = math.random(display.contentHeight)
	elseif spawn_RNG == 2 then	
		self.sprite.x = math.random(display.contentWidth)
		self.sprite.y = 0
	elseif spawn_RNG == 3 then
		self.sprite.x = display.contentWidth
		self.sprite.y = math.random(display.contentHeight)
	else
		self.sprite.x = math.random(display.contentWidth)
		self.sprite.y = display.contentHeight
	end	
	
	self.move()
end

function murder_children:move()

	local cookie_coordX_RNG = math.random(display.contentHeight*0.25, display.contentHeight*0.5)
	local cookie_coordY_RNG = math.random(display.contentWidth*0.40, display.contentWidth*0.75)
	
	local function move_MC( event )
	
		local t = event.time * 0.05
		
		local move_params =
		{
			x = cookie_coordX_RNG,
			y = cookie_coordY_RNG,
			time = 3000,
			transition = easing.linear,
		}
		
		transition.moveTo(self.sprite, move_params)
	end
	
	Runtime:addEventListener( "enterFrame", move_MC)

end

--[[
--called when the child is murdered
function murder_children:remove(m_c_table)
  
  --remove them from the screen
  display.remove(self.sprite)
  
  --remove references to thier table
  m_c_table = nil
  self = nil
  
--end ]]--

return murder_children
