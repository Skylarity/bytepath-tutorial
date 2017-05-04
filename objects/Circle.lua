Circle = GameObject:extend()

function Circle:new(x, y, radius, opts)
    circle.super.new(self, x, y, radius, opts)
    self.timer:tween(random(2, 4), self, {radius = 0}, 'in-out-linear')
end

function Circle:update(dt)
    if self.radius <= 0 then self.dead = true end
end

function Circle:draw()
	love.graphics.circle('fill', self.x, self.y, self.radius)
end
