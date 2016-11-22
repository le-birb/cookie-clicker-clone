

local murder_children = {type = "", health = 0, soul_reward = 1, cps_eaten = 0}

function murder_children:move()
  
  
  
end

function murder_children:new(n_type, n_health, n_soul_reward, n_cps_eaten, n_move_func, sprite_obj)
  new_child = {
    type = n_type, 
    health = n_health, 
    soul_reward = n_soul_reward, 
    cps_eaten = n_cps_eaten,
    move = n_move_func,
    sprite = sprite_obj
  }
  setmetatable(new_child, self)
  self.__index = self
  return new_child
end

