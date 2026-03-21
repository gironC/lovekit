Camara = {}
Camara.__index = Camara

Camara.new = function(vW, vH)
  local self = setmetatable({}, Camara)
  self.vW = vW
  self.vH = vH
  self.x = 0
  self.y = 0
  self.escala = 1
  self.offsetX = 0
  self.offsetY = 0
  self.smooth = false
  self.target = nil
  self.mouseX = 0
  self.mouseY = 0
  return self
end

function Camara:setSmooth(smooth)
  self.smooth = smooth
end

function Camara:setTarget(target)
  self.target = target
  self.x = target.x
  self.y = target.y
end

function Camara:resize(w, h)
  --esto se va a ejecutar en el love.resize
  local scaleX = w / self.vW
  local scaleY = h / self.vH
  self.escala =math.min(scaleX, scaleY)
  self.offsetX = (w - self.vW * self.escala) / 2
  self.offsetY = (h - self.vH * self.escala) / 2
end

function Camara:update(dt)
  if self.target then
    local tx = self.target.x
    local ty = self.target.y
    self.x = self.x + (tx - self.x) * 5 * dt
    self.y = self.y + (ty - self.y) * 5 * dt
  end
  local mx, my = love.mouse.getPosition()
  mx = mx - self.offsetX
  my = my - self.offsetY
  if mx < 0 or my < 0 or
    mx > self.vW * self.escala or
    my > self.vH * self.escala then
    self.mouseX = 0
    self.mouseY = 0
    return
  end
  mx = mx / self.escala
  my = my / self.escala
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

function Camara:push()
  love.graphics.clear(0, 0, 0)
  love.graphics.push()
  love.graphics.setScissor(self.offsetX, self.offsetY, self.vW * self.escala, self.vH * self.escala)
  love.graphics.translate(self.offsetX, self.offsetY)
  love.graphics.scale(self.escala, self.escala)

  if self.target then
    if self.smooth then
      love.graphics.translate(-self.x + self.vW / 2, -self.y + self.vH / 2)
    else
      love.graphics.translate(-self.target.x + self.vW / 2, -self.target.y + self.vH / 2)
    end
  end
end

function Camara:pop()
  love.graphics.setScissor()
  love.graphics.pop()
end