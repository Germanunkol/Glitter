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

local fullScreenCanvas1, fullScreenCanvas2

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
	Shaders:addShader( "plain", "1" )
	Shaders:addShader( "outline thick", "2" )
	Shaders:addShader( "outline thin", "3" )
	Shaders:addShader( "gaussian horizontal", "4" )
	Shaders:addShader( "gaussian vertical", "5" )
	--Shaders:addShader( "gaussian", "g" )
	gaussianH = love.graphics.newShader( "Shaders/gaussianH.glsl" )	
	gaussianV = love.graphics.newShader( "Shaders/gaussianV.glsl" )	
	gaussianH:send( "blurSize", 1/love.graphics.getWidth() )
	gaussianV:send( "blurSize", 1/love.graphics.getHeight() )

	fullScreenCanvas1 = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight() )
	fullScreenCanvas2 = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight() )
end

function love.update( dt )
	chars[1]:update( dt )
	chars[2]:update( dt )
end

function love.draw()

	fullScreenCanvas1:clear()

	love.graphics.setCanvas( fullScreenCanvas1 )
	chars[1]:draw()
	chars[2]:draw()
	love.graphics.setCanvas()

	love.graphics.setColor(255,255,255,255)
	if Shaders:isEnabled( "gaussian horizontal" ) and not Shaders:isEnabled( "gaussian vertical" ) then
		love.graphics.setShader( gaussianH )
		love.graphics.draw( fullScreenCanvas1 )
		love.graphics.setShader()
	elseif Shaders:isEnabled( "gaussian vertical" ) and not Shaders:isEnabled( "gaussian horizontal" ) then
		love.graphics.setShader( gaussianV )
		love.graphics.draw( fullScreenCanvas1 )
		love.graphics.setShader()
	elseif Shaders:isEnabled( "gaussian horizontal" ) and Shaders:isEnabled( "gaussian vertical" ) then
		fullScreenCanvas2:clear()
		love.graphics.setCanvas( fullScreenCanvas2 )
		love.graphics.setShader( gaussianV )
		love.graphics.draw( fullScreenCanvas1 )

		love.graphics.setCanvas()
		love.graphics.setShader( gaussianH )
		love.graphics.draw( fullScreenCanvas2 )
		love.graphics.setShader()
	else
		love.graphics.draw( fullScreenCanvas1 )
	end

	Shaders:draw()

	love.graphics.print( love.timer.getFPS(), 10, love.graphics.getHeight() - 24 )
end

function love.keypressed( key )
	if key == "escape" then
		love.event.quit()
	end
	Shaders:keypressed( key )
end
