-- This is just a "fake" shader - it doesn't change the image
-- at all. It's used to display the plain characters:

local plain = {
	isFullScreenShader = false,
	enabledByDefault = true, -- this is only for the main program
	layer = 0,	-- shaders will be rendered by layers
}

-- local shader		-- could hold your shader

-- Initialise and create your shader in here. This function
-- should call love.graphics.newShader at least once.
-- Please add the shaders into external files in the same
-- folder, with a ".glsl" extension. See the other shaders for
-- an example.
-- The img argument is the image of the skeleton/player images.
-- You can use it for retreiving the size, for example
function plain.init( img )
	-- shader = love.graphics.newShader()
	-- shader:send( "variable", defaultValue )
	-- shader:send( "imgWidth", img:getWidth() )
	-- shader:send( "screenWidth", love.graphics.getWidth() )
end

-- Enable the shader, then call func() - which draws everything
-- that should be drawn - then disable the shader again:
-- Called every frame
function plain.drawFunc( func )
	-- love.graphics.setShader( shader )
	func()
	-- love.graphics.setShader()
end

-- Use this to update your shader
-- Called every frame
function plain.update( dt )
	-- shader:send( "variable", math.random() )
end

return plain
