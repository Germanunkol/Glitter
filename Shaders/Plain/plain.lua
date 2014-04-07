-- This is just a "fake" shader - it doesn't change the image
-- at all. It's used to display the plain characters:

local plain = {
	isFullScreenShader = false,
	enabledByDefault = true,	-- by default?
	layer = 0,
}

function plain.init()

end

function plain.drawFunc( func )
	func()
end

function plain.update( dt )

end

return plain
