-- Example usage of gaussian blur shaders gaussianH and gaussianV
-- The blurring is seperated into two passes because that's much
-- faster than a single blur.

local gaussian = {
	isFullScreenShader = true,
	active = true,
}

local fullScreenCanvas
local gaussianH, gaussianV


function gaussian.init()
	-- Create a new full screen canvas to render the first blur to
	fullScreenCanvas = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight() )

	gaussianH = love.graphics.newShader( "Shaders/GaussianBlur/gaussianH.glsl" )	
	gaussianV = love.graphics.newShader( "Shaders/GaussianBlur/gaussianV.glsl" )

	gaussianH:send( "blurSize", 1/love.graphics.getWidth() )
	gaussianV:send( "blurSize", 1/love.graphics.getHeight() )
end

function gaussian.drawFunc( func )

	-- Clear anything previously drawn to the canvas (Important!)
	fullScreenCanvas:clear()

	-- Blur the drawable horizontally, render to canvas:
	love.graphics.setCanvas( fullScreenCanvas )
	love.graphics.setShader( gaussianH )
	func()
	love.graphics.setCanvas()

	-- Now render the Canvas to the screen, using the vertical
	-- blur:
	love.graphics.setShader( gaussianV )
	love.graphics.draw( fullScreenCanvas )
	love.graphics.setShader()

end

function gaussian.update( dt )
end

return gaussian
