Polygon = Object:extend()

function Polygon:new()
    -- body
end

function Polygon:update(dt)
    -- body
end

function Polygon:draw()
    love.graphics.polygon('fill', 100, 100, 200, 100, 250, 150, 200, 200, 100, 200)
end

function Polygon:activate()
    -- body
end

function Polygon:deactivate()
    -- body
end
