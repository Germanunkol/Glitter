local outline = {
	isFullScreenShader = false,
	enabledByDefault = true,
	layer = 2,
}

local shader
local baseStepSize = {}
local time

function outline.init( img )

	-- Load the shader:
	shader = love.graphics.newShader("Shaders/Outline/outline.glsl")
	-- Send the width and height of a single pixel to the shader:
	-- This allows the shader to accurately acces neighbouring
	-- pixels, which it needs. Check out outline.glsl for how
	-- it's used:
	shader:send( "stepSize", {1/img:getWidth(), 1/img:getHeight() })
	-- We're going to modulate the width (by changing the
	-- stepSize), so remember it for later:
	baseStepSize = {1/img:getWidth(), 1/img:getHeight()}

	-- Start at time = 0:
	time = 0
end

function outline.drawFunc( func )
	-- A nice, bright yellowish green:
	love.graphics.setColor( 128, 255, 0 )
	-- Enable shader:
	love.graphics.setShader( shader )
	-- Draw whatever it was they gave us to draw:
	func()
	-- Disable the shader again:
	love.graphics.setShader()
end

function outline.update( dt )

	-- This is how one could change the thickness of the outline:
	time = time + dt	
	local thickness = math.abs( math.sin( time )*3 ) + 1
	shader:send( "stepSize", {baseStepSize[1]*thickness,
							baseStepSize[2]*thickness })
end

return outline
