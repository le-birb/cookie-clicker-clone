--local murder_children = require "murder_children"

--frame settings for each type of MC
local basic_mc_options =
	{
	frames =
		{
			{ --frame 1; final sprite will have more frames
				x = 0,
				y = 0,
				width = 100,
				height = 100
			}
		}
	}
local super_mc_options = {}
local sneaky_mc_options = {}
local fat_mc_options = {}

--set the sprite settings to the options above
local basic_mc_sheet  = graphics.newImageSheet("resources/mc.png", basic_mc_options)
local super_mc_sheet  = nil
local sneaky_mc_sheet = nil
local fat_mc_sheet    = nil

	--temporary testing-- --set these to the 'sprite' parameter--
local basic_MC  = display.newImage(basic_mc_sheet, 1)
local super_MC  = nil
local sneaky_MC = nil
local fat_MC    = nil