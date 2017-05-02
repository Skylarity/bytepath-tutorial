HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, line_width, outer_radius)
	HyperCircle.super.new(self, x, y, radius)
	self.line_width, self.outer_radius = line_width, outer_radius
end

function HyperCircle:update(dt)
	HyperCircle.super.update(self, dt)
end

function HyperCircle:draw()
	HyperCircle.super.draw(self)

	love.graphics.setLineWidth(self.line_width)
	love.graphics.circle('line', self.x, self.y, self.outer_radius)

	love.graphics.setLineWidth(1)
end
