require 'helpers/helpers'
Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/enhanced_timer/EnhancedTimer'
Moses = require 'libraries/moses/Moses'

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
