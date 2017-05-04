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

    input:bind('return', 'submit-text')
    input:bind('kpenter', 'submit-text')
    input:bind('backspace', 'delete-char')
    lineConstant = '[admin] $ '
    consoleCache = {'Welcome to CompuOS 24.17', '14:21 Wed 5/3/2017', '', lineConstant}
    lineHeight = 20
end

function love.update(dt)
    timer:update(dt)

    if input:pressed('submit-text') then
        if #consoleCache * lineHeight >= love.graphics.getHeight() - (lineHeight * 2) then
            _.pop(consoleCache)
        end
        consoleCache[#consoleCache+1] = lineConstant
    end

    if input:pressed('delete-char') then
        consoleCache[#consoleCache] = consoleCache[#consoleCache]:sub(1, -2)
    end
end

function love.draw()
    for k, line in ipairs(consoleCache) do
        love.graphics.setColor(255,255,255,255)
        love.graphics.print(line, lineHeight, lineHeight * k)
    end
end

function love.textinput(t)
    consoleCache[#consoleCache] = consoleCache[#consoleCache] .. t
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
