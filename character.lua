local Character = {}
Character.__index = Character

local images = {}	-- characters use seperate images depending on type
local quads = {}	-- both characters use the same quads

local QUAD_SIZE = 64	-- quads are 64x64 pixels high (see the .png files)
local ANIMATION_TIME = 0.09

-- Creates and returns a new Character (a new instance of the 'class' Character)
function Character:new( charType )
	local o = {}
	setmetatable( o, Character )

	-- Choose an spritesheet to use for this character:
	o.img = images[charType]
	-- Start at first animation frame:
	o.frame = 1
	o.time = 0
	-- default position:
	o.x = 0
	o.y = 0

	o.shader = love.graphics.newShader( "Shaders/outline.glsl" )

	return o
end

function Character:setPosition( x, y )
	self.x, self.y = x, y
end

function Character:update( dt )
	self.time = self.time + dt	
	-- If I my tim is past the animation step time, go to the next quad:
	if self.time > ANIMATION_TIME then
		self.time = self.time - ANIMATION_TIME
		self.frame = self.frame + 1
		if not quads[self.frame] then
			self.frame = 1
		end
	end
end

function Character:draw()
	if Shaders:isEnabled("plain") then
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw( self.img, quads[self.frame], self.x, self.y )
	end
	if Shaders:isEnabled("outline thick") then
		love.graphics.setColor(100, 255, 0 )
		self.shader:send( "stepSize", {3/self.img:getWidth(), 3/self.img:getHeight()})

		love.graphics.setShader( self.shader )
		love.graphics.draw( self.img, quads[self.frame], self.x, self.y )
		love.graphics.setShader()
	end
	if Shaders:isEnabled("outline thin") then
		love.graphics.setColor(100, 255, 0 )
		self.shader:send( "stepSize", {1/self.img:getWidth(), 1/self.img:getHeight()})
		love.graphics.setShader( self.shader )
		love.graphics.draw( self.img, quads[self.frame], self.x, self.y )
		love.graphics.setShader()
	end
end

-----------------------------------------------
-- Initialize the class at startup (load images etc):
function Character:init()
	images["skeleton"] = love.graphics.newImage("Images/skeleton_3.png")
	images["spearguy"] = love.graphics.newImage("Images/spear_walk_m.png")

	-- Create the 9 quads for walking animation:
	-- Walking animation is in the 11th row of the sprite sheet:
	for i = 1, 8 do
		quads[i] = love.graphics.newQuad( (i-1)*QUAD_SIZE, 11*QUAD_SIZE,
						QUAD_SIZE, QUAD_SIZE,
						images["skeleton"]:getWidth(), images["skeleton"]:getHeight() )
	end
end

return Character
