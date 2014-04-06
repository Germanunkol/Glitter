-- Framework for disabling and enabling shaders quickly.

local Shaders = {}

local shaderList = {}
local shadersByName = {}

function Shaders:addShader( name, key )
	local s = {
		name = name,
		key = key,
		enabled = true,
	}
	table.insert(shaderList, s)
	shadersByName[name] = s
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

return Shaders
