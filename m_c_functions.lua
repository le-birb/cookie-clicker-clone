
local widget = require "widget"
local user_data = require "userData.lua"


local murder_children_functions = {}

function murder_children_functions.spawn(child_type)
  
  local murder_child = {
    "health" = murder_children[child_type].health,
    "soul_reward" = murder_children[child_type].soul_reward,
    "movement" = murder_children[child_type].movement,
	}
  
  local mc_options = {
    label = "M.C."
    shape = "circle"
    radius = 20
    onEvent = function() murder_child.health -= 1 end,
  }
  
  local murder_child_object = widget.newButton
  
  mc_move = coroutine.create(murder_children.movement)
  
  user_data[3] += murder_child.soul_reward
  
  display.remove(murder_child_object)
  
end

return murder_chlidren_functions
