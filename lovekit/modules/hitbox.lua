local Hitbox = {}
Hitbox.__index = Hitbox

function Hitbox:new(x, y, w, h, offX, offY)
  local self = setmetatable({}, Hitbox)
  self.offsetX = offX or 0
  self.offsetY = offY or 0
  self.x = x + self.offsetX
  self.y = y + self.offsetY
  self.w = w
  self.h = h
  return self
end

function Hitbox:update(x, y, w, h)
  self.x = x + self.offsetX
  self.y = y + self.offsetY
  self.w = w or self.w
  self.h = h or self.h
end

function Hitbox:checkCollision(obj)
  return self.x < obj.x + obj.w and
    self.x + self.w > obj.x and
    self.y < obj.y + obj.h and
    self.y + self.h > obj.y
end

function Hitbox:draw()
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

return Hitbox