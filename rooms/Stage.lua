Stage = Room:extend()

function Stage:new(...)
    self.super.new(self)
    self.area = Area()
    self.timer:every(2, function()
        self.area:addGameObject('Circle', random(0, love.graphics.getWidth(), love.graphics.getHeight(), random(10, 50)))
    end)
end
