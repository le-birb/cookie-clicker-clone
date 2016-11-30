
local io = require "io"

local user_data = {} -- here is a table

user_data.cookies = nil --number of cookies the user has
user_data.cookie_tap = nil --how many cookies earned per tap
user_data.souls = nil --how many souls the user has collected
user_data.cps = nil --cps
user_data.buildings = {} --stores building dataa

function user_data.save(file_name) 
  
  --open the target file in write mode
  local file = io.open("saves/"file_name, "w")
  
  --set the target file as the default output file
  io.output(file)
  
  --print cookie amount and tap strength
  io.write("cookies "..tostring(user_data.cookies).."\n")
  io.write("tap_strength "..tostring(user_data.cookie_tap).."\n")
  io.write("souls "..tostring(user_data.cps).."\n")
  
  --write buildings to save file
  --start with "buildings {"
  io.write("buildings {\n")
  
  --retrieve the table that holds building data
  local buildings = user_data.buildings
  
  --iterate through the buildings
  for key, element in pairs(buildings) do
    
    --print the building name
    io.write(key.." ")
	io.write()
    
    --iterate through building parameters
    for parameter, value in pairs(element) do
      
      --print the parameters
      io.write(parameter.." "..tostring(value).."\n")
      
    end
    
  end
  
  --close the braces
  io.write("\}\n")
  
end

function user_data.load(file_name)
  
  --open target file in read mode
  local file = io.open("saves/"file_name, "r")
  
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
    if string.find(line, "^cookies".."%s") then
      
      --throw an error if there is no number
      assert(string.find(line, "^cookies".."%s+".."%d+"), "ERROR: number expected after \'cookies\'")
      
      --load the number as number of cookies
      user_data.cookies =  tonumber(string.sub(string.find(line, "%d+")))
      
    --if the line begins with tap_strength
    elseif string.find(line, "^tap_strength".."%s+") then
      
      --throw an error if there is no number
      assert(string.find(line, "^tap_strength".."%s+".."%d+", "ERROR: number expected after tap_strength"))
      
	  --load tap_strength
      user_data.cookie_tap = tonumber(string.sub(string.find(line, "%d+")))
	  
    --if the line begins with souls
    elseif string.find(line, "^souls".."%s") then
      
      --throw an error if there is no number
      assert(string.find(line, "^souls".."%s+".."%d+", "ERROR: number expected after souls"))
      
	  --load souls
      user_data.cps = tonumber(string.sub(string.find(line, "%d+")))
	  
	--if the line begins with buildings
    elseif string.find(line, "^buildings".."%s") then
	  
	  --throw an error if '{' is missing
	  assert(string.find(line, "^buildings".."%S".."\{"), "ERROR: \'{\' expected after buildings")
      
	  --move the file position to the next line
	  io.read("*l")
	  
	  --increment line counter
	  line_number = line_number + 1
	  
	  --read each line until "}" is found
	  while io.read() ~= "}" do
        
      --store the current line and move file position down 1 line
      local building_string = io.read("*l")
      
      --increment line counter
      line_number = line_number + 1
      
        --check if the line has correct syntax
        if building_string == "%a owned %d+ cps %d+ base_price %d+" then
          
          --if it does retrieve the building name
          local building_name = string.sub(string.find(line, "%d+"))
          
          --initialize the table to hold the data for the building
          user_data.buildings[building_name] = {}
          
          --set a short name for the table
          local building_t = user_data.buildings[building_name]
          
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
  assert(user_data.cookies, "ERROR: did not find a value for cookies" )
  
  assert(user_data.t["tap_strength"], "ERROR: did not find a value for tap_strength")
  
end

return user_data 
