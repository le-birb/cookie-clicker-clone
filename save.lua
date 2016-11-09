
io = require "io"

user_data = require "userData.lua"

function save(file_name) 
  
  --open the target file in write mode
  file = io.open(file_name..".txt", "w")
  
  --set the target file as the default output file
  io.output(file)
  
  --print cookie amount and tap strength
  io.write("cookies "..tostring(user_data.t["cookies"].."\n"))
  io.write("tap_strength "..tostring(user_data.t["tap_strength"].."\n"))
  
  --write buildings to save file
  --start with "buildings {"
  io.write("buildings {\n")
  
  --retrieve the table that holds building data
  buildings = user_data.t["buildings"]
  
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

function load(file_name)
  
  --open target file in read mode
  file = io.open(file_name, "r")
  
  --set target file as the default input file
  io.input(file)
  
  --line counter for debug purposes
  line_number = 0
  
  --iterate through each line of the file
  for line in io.lines(file) do
    
	--increment the line counter each time the program moves down a line
	line_number = line_number + 1
	
    --check if the line has relevant data
    --if the line begins with cookies
    if string.find(line, "^cookies".."%s+") do
      
      --throw an error if there is no number
      assert(string.find(line, "^cookies".."%s+".."%d+"), "ERROR: number expected after \'cookies\'")
      
      --load the number as number of cookies
      user_data.t["cookies"] =  tonumber(string.sub(string.find(line, "%d+")))
      
    --if the line begins with tap_strength
    else if string.find(line, "^tap_strength".."%s+") do
      
      --throw an error if there is no number
      assert(string.find(line, "^cookies".."%s+".."%d+", "ERROR: number expected after tap_strength")
      
	  --load tap_strength
      user_data.t["tap_strength"] = tonumber(string.sub(string.find(line, "%d+")))
      
	--if the line begins with buildings
    else if string.find(line, "^buildings") do
	  
	  --throw an error if '{' is missing
	  assert(string.find(line, "^buildings".."%S".."\{"), "ERROR: \'{\' expected after buildings")
      
	  --move the file position to the next line
	  io.read("*l")
	  
	  --increment line counter
	  line_number = line_number + 1
	  
	  --read each line until "}" is found
	  while(io.read() ~= "}") do
	    
		--store the current line and move file position down 1 line
		building_string = io.read(*l)
		
		--increment line counter
		line_number = line_number + 1
		
		--check if the line has correct syntax
		if building_string == "%a owned %d+ cps %d+ base_price %d+"
		  
		  --if it does retrieve the building name
		  building_name = string.sub(string.find(line, "%d+"))
		  
		  --initialize the table to hold the data for the building
		  user_data.t["buildings"][building_name] = {}
		  
		  --set a short name for the table
		  building_t = user_data.t["buildings"][building_name]
		  
		  --create a loop to store the building data
		  for key, element in pairs({"owned", "cps", "base_cost"}) do
			  
			  --retrieve the substring containing the desired element
			  element = string.sub(string.find(building_string, element.." %d+"))
			  
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
  assert(user_data.t["cookies"], "ERROR: did not find a value for cookies" )
  
  assert(user_data.t["tap_strength", "ERROR: did not find a value for tap_strength")
  
end
