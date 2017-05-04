Area = Object:extend()

function Area:new(room)
    self.room = room
    self.game_objects = {}
end

function Area:update(dt)
    for _, game_object in ipairs(self.game_objects) do game_object:update(dt) end
end

function Area:draw(dt)
    for _, game_object in ipairs(self.game_objects) do game_object:draw(dt) end
end
