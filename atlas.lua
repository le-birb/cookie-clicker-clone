--local murder_children = require "murder_children"

local atlas = {}

--frame settings for each type of MC
local basic_mc_options =
	{
		width = 100,
		height = 100,
		numFrames = 2
	--[[frames =
		{
			{ --frame 1; final sprite will have more frames
				x = 0,
				y = 0,
				width = 100,
				height = 100
			}
		}]]--
	}
local super_mc_options = {}
local sneaky_mc_options = {}
local fat_mc_options = {}

 atlas.sequences_basicMC = {
	
	{
		name = "move",
		start = 1,
		count = 2,
		time = 1000,
		loopCount = 0,
		loopDirection = "bounce"
	}
}

--set the sprite settings to the options above
  atlas.basic_mc_sheet  = graphics.newImageSheet("resources/mc_animation.png", basic_mc_options)
 local super_mc_sheet  = nil
 local sneaky_mc_sheet = nil
 local fat_mc_sheet    = nil

	--temporary testing-- --set these to the 'sprite' parameter--
 --atlas.basic_MC  = display.newImage(basic_mc_sheet, 1)
 atlas.super_MC  = nil
 atlas.sneaky_MC = nil
 atlas.fat_MC    = nil

 return atlas
