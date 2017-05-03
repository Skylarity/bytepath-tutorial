Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/enhanced_timer/EnhancedTimer'
_ = require 'libraries/moses/Moses'

function love.load()
	--[[ REQUIRES ]]--
	local object_files = {}
	recursiveEnumerate('objects', object_files)
	requireFiles(object_files)

	--[[ INITIALIZATION ]]--
	input = Input()
	timer = Timer()
end

function love.update(dt)
	timer:update(dt)

	--
end

function love.draw()
	--
end

--[[ HELPERS ]]--

function recursiveEnumerate(folder, file_list)
	local items = love.filesystem.getDirectoryItems(folder)

	for k, item in ipairs(items) do
		local file = folder .. '/' .. item

		if love.filesystem.isFile(file) then
			table.insert(file_list, file)
		elseif love.filesystem.isDirectory(file) then
			recursiveEnumerate(file, file_list)
		end
	end
end

function requireFiles(files)
	for k, file in ipairs(files) do
		local file = file:sub(1, -5)
		require(file)
	end
end
