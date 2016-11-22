
local widget = require "widget"
local user_data = require "user_data"
local timer = require "timer"

local murder_children = require "murder_children"

local m_c_functions = {}

local function sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end

--this function spawns a murder child (not yet complete)
--call as a coroutine so it doesn't halt program
function m_c_functions.spawn(child_type)
  
  local murder_child = {
    health = murder_children[child_type].health,
    soul_reward = murder_children[child_type].soul_reward,
    movement = murder_children[child_type].movement,
    cps_eaten = murder_children[child_type].cps_eaten
	}
  
  local mc_options = {
    label = "M.C.",
    shape = "circle",
    radius = 20,
    onEvent = function() murder_child.health = murder_child.health - 1 end,
  }
  
  local murder_child_object = widget.newButton
  
  mc_move = coroutine.create(murder_children[child_type].movement)
  
  user_data[4] = user_data[4] - murder_child.cps_eaten
  
  coroutine.resume(mc_move, murder_child_object)
  
  --[[while murder_child.health > 0 do
	print("thing happened")
    coroutine.resume(mc_move, true)
	sleep(.05)
  end]]--
  while murder_child.health > 0 do
	timer.performWithDelay(coroutine.resume(mc_move, true), .02)
  end
  
  coroutine.resume(mc_move, false)
  
  
  
end

function m_c_functions.kill(murder_child_object)
  user_data[4] = user_data[4] + murder_child.cps_eaten
  
  user_data[3] = user_data[3] + murder_child.soul_reward
  
  display.remove(murder_child_object)
end

return m_c_functions
