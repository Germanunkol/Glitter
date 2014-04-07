-- Tutorial Framework
-- By Germanunkol, April 2014
-- Code release under the "Do What The Fuck You Want To Public License" (see http://www.wtfpl.net for details )

-- Image files are from here (Skeleton):
-- http://opengameart.org/content/lpc-skeleton
-- And here (Spear man):
-- http://opengameart.org/content/spear-walk
-- Both are released under Creative Common Licenses, make sure to visit the Links for more details before using the images in your own projects.
-- Thanks to the authors!

Character = require("character")
Shaders = require("shaders")

local chars = {}

local fullScreenCanvas

function love.load()

	-- initialize character class:
	Character:init()
	
	-- create and remember two characters - a skeleton and a 
	chars[1] = Character:new("skeleton")
	chars[2] = Character:new("spearguy")

	chars[1]:setPosition( love.graphics.getWidth()/3-34, love.graphics.getHeight()/2-40 )
	chars[2]:setPosition( 2*love.graphics.getWidth()/3-34, love.graphics.getHeight()/2-40 )

	love.graphics.setFont( love.graphics.newFont(14) )

	-- To add a new "Shader", use a line similar to the following.
	-- This will not really create a shader, only display a text at the top which can be used
	-- to disable and enable shaders. In order for this to work, functions using shaders MUST
	-- poll Shader:isEnabled( "outline" ) or similar before using shaders.
	--Shaders:addShader( "gaussian", "g" )

	fullScreenCanvas = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight() )

	Shaders:init( Character:getImage("skeleton") )
end

function love.update( dt )
	chars[1]:update( dt )
	chars[2]:update( dt )
	Shaders:update( dt )
end

function love.draw()

	fullScreenCanvas:clear()

	-- Draw the two characters to a canvas:
	love.graphics.setCanvas( fullScreenCanvas )
	Shaders:drawAllFunc( function() chars[1]:draw() end )
	Shaders:drawAllFunc( function() chars[2]:draw() end )
	love.graphics.setCanvas()
	
	love.graphics.setColor(255,255,255,255)

	-- If any full screen shaders are active, render the canvas
	-- using those shaders. Otherwise just render the canvas
	-- directly to the screen:
	if not Shaders:drawAllFullScreen( fullScreenCanvas ) then
		love.graphics.draw( fullScreenCanvas )
	end

	-- display UI info:
	Shaders:draw()
	love.graphics.print( love.timer.getFPS(), 10, love.graphics.getHeight() - 24 )
end

function love.keypressed( key )
	if key == "escape" then
		love.event.quit()
	end
	Shaders:keypressed( key )
end
