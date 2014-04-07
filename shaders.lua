-- Framework for disabling and enabling shaders quickly.

local Shaders = {}

local shaderList = {}
local shadersByName = {}

-- This is used to sort the execution order (and displaying order) of shaders.
-- First, all non-fullscreen shaders are executed. Then, all fullscreen shaders.
-- Within both categories, the function sorts by the shaders' layers and names.
local function sortShaders( a, b )
	if a and b then
		if a.shader.isFullScreenShader == b.shader.isFullScreenShader then
			if a.shader.layer == b.shader.layer then
				return a.name < b.name
			else
				return a.shader.layer < b.shader.layer
			end
		else
			return a.shader.isFullScreenShader == false
		end
		return false
	else
		return true
	end
end

function Shaders:init( img )
	local shaderFolders = love.filesystem.getDirectoryItems("Shaders")
	for k, name in ipairs(shaderFolders) do
		print( "Found shader:", name )
		local file = "Shaders/" .. name .. "/" ..	string.lower( name ) .. ".lua" 
		local shader = dofile( file )
		if not shader.layer then shader.layer = 0 end

		table.insert( shaderList, { name = name,
			shader = shader,
			enabled = shader.enabledByDefault and true or false,
		} )
		if shader.init then
			shader.init(img)
		end
	end

	-- sort according to layers and name:
	table.sort( shaderList, sortShaders )
	
	for k, s in ipairs( shaderList ) do
		shadersByName[s.name] = s
		s.key = tostring(k)
	end
end

local savedCanvas, savedColor, savedShader
function Shaders:rememberState()
	savedCanvas = love.graphics.getCanvas()
	savedColor = {love.graphics.getColor()}
	savedShader = love.graphics.getShader()
end

function Shaders:recallState()
	love.graphics.setColor( savedColor)
	love.graphics.setShader( savedShader )
	love.graphics.setCanvas( savedCanvas )
end

function Shaders:drawAll( drawable )
	Shaders:rememberState()
	for k, s in ipairs(shaderList) do
		if not s.shader.isFullScreenShader then
			if s.enabled and s.shader.draw then
				s.shader.draw( drawable )
				Shaders:recallState()
			end
		end
	end
end

function Shaders:drawAllFunc( func )
	Shaders:rememberState()
	for k, s in ipairs(shaderList) do
		if not s.shader.isFullScreenShader then
			if s.enabled and s.shader.drawFunc then
				s.shader.drawFunc( func )
				Shaders:recallState()
			end
		end
	end
end

function Shaders:drawAllFullScreen( func )
	local foundActive = false
	Shaders:rememberState()
	for k, s in ipairs(shaderList) do
		if s.shader.isFullScreenShader then
			if s.enabled then
				s.shader.drawFunc( func )
				Shaders:recallState()
				foundActive = true
			end
		end
	end
	return foundActive
end

function Shaders:draw()
	local str
	local fontHeight = love.graphics.getFont():getHeight()
	for k, s in ipairs(shaderList) do
		if s.enabled then
			str = "[ " .. s.key .. " ]: " .. s.name .. " On"
		else
			str = "[ " .. s.key .. " ]: " .. s.name .. " Off"
		end
		love.graphics.print( str, 10, 10 + (k-1)*fontHeight )
	end
end

function Shaders:keypressed( key )
	for k, s in ipairs(shaderList) do
		if s.key == key then
			self:toggle( s.name )
			break
		end
	end
end

function Shaders:findByName( name )
	for k, s in ipairs( shaderList ) do
		if s.name == name then return s,k end
	end
end

function Shaders:toggle( name )
	if shadersByName[name] then
		shadersByName[name].enabled = (shadersByName[name].enabled == false)
	end
end

function Shaders:isEnabled( name )
	return shadersByName[name] and shadersByName[name].enabled or false
end

function Shaders:enable( name )
	if shadersByName[name] then shadersByName[name].enabled = true end
end
function Shaders:disable( name )
	if shadersByName[name] then shadersByName[name].enabled = false end
end

function Shaders:update( dt )
	for k, s in ipairs( shaderList ) do
		if s.enabled and s.shader.update then
			s.shader.update( dt )
		end
	end
end

return Shaders
