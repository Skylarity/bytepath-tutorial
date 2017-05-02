Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/enhanced_timer/EnhancedTimer'

function love.load()
	--[[ REQUIRES ]]--
	local object_files = {}
	recursiveEnumerate('objects', object_files)
	requireFiles(object_files)

	--[[ INITIALIZATION ]]--
	input = Input()
	timer = Timer()

	circle = HyperCircle(400, 300, 50, 10, 100)
	input:bind('mouse1', 'circle')
end

function love.update(dt)
	circle:update(dt)
	if input:pressed('circle') then
		new_circle = circle
		new_circle.radius = love.math.random() * 25 + 25
		new_circle.outer_radius = new_circle.radius + love.math.random() * 10 + 40
		timer:tween('circle', 10, circle, new_circle, 'out-elastic')
	end
end

function love.draw()
	circle:draw()
end

--[[ HELPERS ]]--

function recursiveEnumerate(folder, file_list)
	local items = love.filesystem.getDirectoryItems(folder)

	for _, item in ipairs(items) do
		local file = folder .. '/' .. item

		if love.filesystem.isFile(file) then
			table.insert(file_list, file)
		elseif love.filesystem.isDirectory(file) then
			recursiveEnumerate(file, file_list)
		end
	end
end

function requireFiles(files)
	for _, file in ipairs(files) do
		local file = file:sub(1, -5)
		require(file)
	end
end
