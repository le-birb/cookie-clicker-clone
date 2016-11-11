
local io = require "io"

local user_data_m = {} -- here is a table

user_data_m[1] = nil --number of cookies the user has
user_data_m[2] = nil --how many cookies earned per tap
user_data_m[3] = {} --stores building dataa

local user_cookies = user_data[1]
local user_tap_strength = user_data[2]
local user_buildings = user_data[3]

function user_data_m.save(file_name) 
  
  --open the target file in write mode
  local file = io.open(file_name..".txt", "w")
  
  --set the target file as the default output file
  io.output(file)
  
  --print cookie amount and tap strength
  io.write("cookies "..tostring(user_cookies).."\n")
  io.write("tap_strength "..tostring(user_tap_strength).."\n")
  
  --write buildings to save file
  --start with "buildings {"
  io.write("buildings {\n")
  
  --retrieve the table that holds building data
  local buildings = user_buildings
  
  --iterate through the buildings
  for key, element in pairs(buildings) do
    
    --print the building name
    io.write(key)
    
    --iterate through building parameters
    for parameter, value in pairs(element) do
      
      --print the parameters
      io.write(parameter.." "..tostring(value).."\n")
      
    end
    
  end
  
  --close the braces
  io.write("\}\n")
  
end

function user_data_m.load(file_name)
  
  --open target file in read mode
  local file = io.open(file_name, "r")
  
  --set target file as the default input file
  io.input(file)
  
  --line counter for debug purposes
  local line_number = 0
  
  --iterate through each line of the file
  for line in io.lines(file) do
    
	--increment the line counter each time the program moves down a line
	line_number = line_number + 1
	
    --check if the line has relevant data
    --if the line begins with cookies
    if string.find(line, "^cookies".."%s+") then
      
      --throw an error if there is no number
      assert(string.find(line, "^cookies".."%s+".."%d+"), "ERROR: number expected after \'cookies\'")
      
      --load the number as number of cookies
      user_cookies =  tonumber(string.sub(string.find(line, "%d+")))
      
    --if the line begins with tap_strength
    elseif string.find(line, "^tap_strength".."%s+") then
      
      --throw an error if there is no number
      assert(string.find(line, "^cookies".."%s+".."%d+", "ERROR: number expected after tap_strength")
      
	  --load tap_strength
      user_tap_strength = tonumber(string.sub(string.find(line, "%d+")))
      
	--if the line begins with buildings
    elseif string.find(line, "^buildings") then
	  
	  --throw an error if '{' is missing
	  assert(string.find(line, "^buildings".."%S".."\{"), "ERROR: \'{\' expected after buildings")
      
	  --move the file position to the next line
	  io.read("*l")
	  
	  --increment line counter
	  line_number = line_number + 1
	  
	  --read each line until "}" is found
	  while(io.read() ~= "}") do
	    
		--store the current line and move file position down 1 line
		local building_string = io.read("*l")
		
		--increment line counter
		line_number = line_number + 1
		
		--check if the line has correct syntax
		if building_string == "%a owned %d+ cps %d+ base_price %d+" then
		  
		  --if it does retrieve the building name
		  local building_name = string.sub(string.find(line, "%d+"))
		  
		  --initialize the table to hold the data for the building
		  user_buildings[building_name] = {}
		  
		  --set a short name for the table
		  local building_t = user_buildings[building_name]
		  
		  --create a loop to store the building data
		  for key, element in pairs({"owned", "cps", "base_cost"}) do
			  
			  --retrieve the substring containing the desired element
			  local element = string.sub(string.find(building_string, element.." %d+"))
			  
			  --save the number in the substring to the respective index
			  building_t[element] = tonumber(string.sub(string.find(owned, "%d+")))
			  
		  end
		  
		--if syntax is not correct, ignore it and print a debug statement
		else
		  
		  print("line "..tostring(line_number)..": incorrect syntax")
		  
		end
		
	  end
	  
    end
    
  end
  
  --throw errors if eithet cookies or tap_strength were not found
  assert(user_cookies, "ERROR: did not find a value for cookies" )
  
  assert(user_data.t["tap_strength", "ERROR: did not find a value for tap_strength")
  
end

return user_data_m 
