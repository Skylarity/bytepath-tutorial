Circle = Object:extend()

function Circle:new(x, y, radius)
	self.x, self.y, self.radius = x, y, radius
	self.creation_time = love.timer.getTime()
end

function Circle:update(dt)

end

function Circle:draw()
	love.graphics.circle('fill', self.x, self.y, self.radius)
end
