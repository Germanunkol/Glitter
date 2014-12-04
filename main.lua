-- Tutorial Framework
-- By Germanunkol, April 2014
-- Code release under the "Do What The Fuck You Want To Public License" (see http://www.wtfpl.net for details )

-- Image files are from here (Skeleton):
-- http://opengameart.org/content/lpc-skeleton
-- And here (Spear man):
-- http://opengameart.org/content/spear-walk
-- Both are released under Creative Common Licenses, make sure to visit the Links for more details before using the images in your own projects.
-- Thanks to the authors!

Shaders = require("shaders")
PunchUI = require("PunchUI")


local fullScreenCanvas

function love.load()

	
		love.graphics.setFont( love.graphics.newFont(14) )

	-- To add a new "Shader", use a line similar to the following.
	-- This will not really create a shader, only display a text at the top which can be used
	-- to disable and enable shaders. In order for this to work, functions using shaders MUST
	-- poll Shader:isEnabled( "outline" ) or similar before using shaders.
	--Shaders:addShader( "gaussian", "g" )

	fullScreenCanvas = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight() )

	Shaders:init( Character:getImage("skeleton") )


	--PunchUI.
	--gaussianH:send( "blurSize", { 1/img:getWidth(), 1/img:getHeight() } )
end

function love.update( dt )
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
	if not Shaders:drawAllFullScreen( function()
			love.graphics.draw(fullScreenCanvas)
		end) then
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
