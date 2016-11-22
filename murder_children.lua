
local math = require "math"
local os = require "os"

<<<<<<< HEAD
local murder_children = {}

local center  = {x = display.contentWidth * 0.5, y = display.contentHeight * 0.5}
local radius = display.contentWidth * 0.4


murder_children.basic = {health = 10, soul_reward = 1, cps_eaten = .5}
=======
local muder_children = {}

local center  = {"x" = display.contentWidth * 0.5, "y" = display.contentHeight * 0.5}
local radius = display.contentWidth * 0.4


murder_children.basic = {"health" = 10, "soul_reward" = 1}
>>>>>>> e58c2b44275c2b65e7a7807933fc8fb35f826618

murder_children.basic["movement"] = function(murder_child) 
  
  local theta = 0
  
  local deg_per_sec = 162
  
  local start_time = os.time()
  
<<<<<<< HEAD
  local continue = true
  
  while continue do
    
    theta = theta + deg_per_sec * (os.time() - start_time)
=======
  while true do
    
    theta += deg_per_sec * (os.time() - start_time)
>>>>>>> e58c2b44275c2b65e7a7807933fc8fb35f826618
    
    start_time = os.time()
    
    murder_child.x = radius * math.cos(math.rad(theta))
    murder_dhild.y = radius * math.sin(math.rad(theta))
    
    if theta >= 360 then
<<<<<<< HEAD
      theta = theta -  360
    end
    
    continue = coroutine.yield()
    
  end
  
end

return murder_children
=======
      theta -= 360
    end
    
    sleep(.02)
    
  end
  
  local function sleep(s)
    local ntime = os.clock() + s
    repeat until os.clock() > ntime
  end
  
end
>>>>>>> e58c2b44275c2b65e7a7807933fc8fb35f826618
