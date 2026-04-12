local Camera = {}
Camera.__index = Camera

Camera.new = function(vW, vH)
  local self = setmetatable({}, Camera)
  self.vW = vW
  self.vH = vH
  self.x = 0
  self.y = 0
  self.scale = 1
  self.offsetX = 0
  self.offsetY = 0
  self.smooth = false
  self.smoothTime = 0
  self.target = nil
  self.mouseX = 0
  self.mouseY = 0
  return self
end

function Camera:setSmooth(smooth, time)
  self.smooth = smooth
  self.smoothTime = time
end

function Camera:setTarget(target)
  self.target = target
  self.x = target.x
  self.y = target.y
end

function Camera:getDimensions()
  return self.vW, self.vH
end

function Camera:getWidth()
  return self.vW
end

function Camera:getHeight()
  return self.vH
end

function Camera:resize(w, h)
  --esto se va a ejecutar en el love.resize
  local scaleX = w / self.vW
  local scaleY = h / self.vH
  self.scale =math.min(scaleX, scaleY)
  self.offsetX = (w - self.vW * self.scale) / 2
  self.offsetY = (h - self.vH * self.scale) / 2
end

function Camera:update(dt)
  local t = 1 - math.exp(-dt / self.smoothTime)
  if self.target then
    local tx = self.target.x
    local ty = self.target.y
    self.x = self.x + (tx - self.x) * t
    self.y = self.y + (ty - self.y) * t
  end
  local mx, my = love.mouse.getPosition()
  mx = mx - self.offsetX
  my = my - self.offsetY
  if mx < 0 or my < 0 or
    mx > self.vW * self.scale or
    my > self.vH * self.scale then
    self.mouseX = 0
    self.mouseY = 0
    return
  end
  mx = mx / self.scale
  my = my / self.scale
  if self.target then
    if self.smooth then
      mx = mx + self.x - self.vW / 2
      my = my + self.y - self.vH / 2
    else
      mx = mx + self.target.x - self.vW / 2
      my = my + self.target.y - self.vH / 2
    end
  end
  self.mouseX = math.floor(mx)
  self.mouseY = math.floor(my)
end

function Camera:push()
  love.graphics.push()
  love.graphics.setScissor(self.offsetX, self.offsetY, self.vW * self.scale, self.vH * self.scale)
  love.graphics.translate(self.offsetX, self.offsetY)
  love.graphics.scale(self.scale, self.scale)

  if self.target then
    if self.smooth then
      love.graphics.translate(-math.floor(self.x) + self.vW / 2, -math.floor(self.y) + self.vH / 2)
    else
      love.graphics.translate(-math.floor(self.target.x) + self.vW / 2, -math.floor(self.target.y) + self.vH / 2)
    end
  end
end

function Camera:pop()
  love.graphics.setScissor()
  love.graphics.pop()
end

function Camera:screenPush()
  love.graphics.push()
  love.graphics.setScissor(self.offsetX, self.offsetY, self.vW * self.scale, self.vH * self.scale)
  love.graphics.translate(self.offsetX, self.offsetY)
  love.graphics.scale(self.scale, self.scale)
end

function Camera:screenPop()
  love.graphics.setScissor()
  love.graphics.pop()
end

return Camera