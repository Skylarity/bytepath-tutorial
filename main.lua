Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/enhanced_timer/EnhancedTimer'
_ = require 'libraries/moses/Moses'

function love.load()
	--[[ REQUIRES ]]--
	local files = {}
	recursiveEnumerate('objects', files)
	recursiveEnumerate('rooms', files)
	requireFiles(files)

	--[[ INITIALIZATION ]]--
	input = Input()
	timer = Timer()

	--[[ ROOMS ]]--
	rooms = {}
	current_room = nil

	gotoRoom('Menu', 'menu')

	input:bind('1', function() gotoRoom('Menu', 'menu') end)
	input:bind('2', function() gotoRoom('Polygon', 'polygon') end)
end

function love.update(dt)
	timer:update(dt)
	if current_room then current_room:update(dt) end

	--
end

function love.draw()
	if current_room then current_room:draw() end
	--
end

--[[ HELPERS ]]--

function addRoom(room_type, room_name, ...)
	local room = _G[room_type](room_name, ...)
	rooms[room_name] = room
	return room
end

function gotoRoom(room_type, room_name, ...)
	if current_room and rooms[room_name] then
		if current_room.deactivate then current_room:deactivate() end
		current_room = rooms[room_name]
		if current_room.activate then current_room:activate() end
	else
		current_room = addRoom(room_type, room_name, ...)
	end
end

--[[ LOADING ]]--

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
