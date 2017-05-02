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

	input:bind('mouse1', 'damage')
	input:bind('r', 'reset')

	hp = {front = 100, back = 100}
end

function love.update(dt)
	timer:update(dt)

	if input:pressed('damage') then
		local new_hp = hp.front - (love.math.random() * 20)
		if new_hp <= 0 then new_hp = 0 end
		timer:tween('front_hp', .2, hp, {front = new_hp}, 'out-quad')
		timer:tween('back_hp', .8, hp, {back = new_hp}, 'in-out-quad')
	end

	if input:pressed('reset') then
		timer:tween('front_hp', 1, hp, {front = 100}, 'out-quad')
		timer:tween('back_hp', 2, hp, {back = 100}, 'in-out-quad')
	end
end

function love.draw()
	love.graphics.setColor(100, 20, 0, 255)
	love.graphics.rectangle('fill', 400 - 200, 300 - 50, (4) * hp.back, 100)
	love.graphics.setColor(255, 50, 0, 255)
	love.graphics.rectangle('fill', 400 - 200, 300 - 50, (4) * hp.front, 100)
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
