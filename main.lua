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

	hyper_circle = HyperCircle(400, 300, 50, 10, 100)
	input:bind('mouse1', 'circle')
	timer:every(1, function()
		print 'wow'
	end)
end

function love.update(dt)
	hyper_circle:update(dt)
	if input:pressed('circle') then
		-- local new_radius = love.math.random() * 25 + 25
		-- local new_outer_radius = new_radius + love.math.random() * 10 + 40
		-- timer:tween(1, hyper_circle, {radius = new_radius}, 'out-elastic')
		-- timer:tween(2, hyper_circle, {outer_radius = new_outer_radius}, 'out-elastic')
		timer:after(2, function()
			-- hyper_circle.radius = love.math.random() * 25 + 25
			-- hyper_circle.outer_radius = hyper_circle.radius + love.math.random() * 10 + 40
			print("wow")
		end)
	end
end

function love.draw()
	hyper_circle:draw()
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
