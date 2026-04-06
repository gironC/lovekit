local Sprites = {}
Sprites.__index = Sprites

function Sprites:new(img, rows, cols, width, height, animList)
  local self = setmetatable({}, Sprites)
  self.img = img
  self.rows = rows
  self.cols = cols
  self.width = width
  self.height = height
  -- {name, frames, delay, loop, nextAnim}
  self.animList = animList
  -- variables para control de animacion
  self.frame = 1
  self.time = 0
  self.currentAnim = 1
  --
  self.quads = {}
  for i = 0, rows - 1 do
    table.insert(self.quads, {})
    for j = 0, cols - 1 do
      local quad = love.graphics.newQuad(j * width, i * height, width, height, img:getDimensions())
      table.insert(self.quads[i + 1], quad)
    end
  end
  return self
end

function Sprites:update(dt)
  local ret = {frame = 1, change = false}
  self.time = self.time + dt
  local anim = self.animList[self.currentAnim]
  if self.time >= anim.delay then
    self.time = 0
    self.frame = self.frame + 1
    ret.frame = self.frame
    ret.change = true
    if self.frame > anim.frames then
      self.frame = 1
      if not anim.loop then
        self.currentAnim = findNext(self.animList, anim.nextAnim)
        if self.currentAnim == 0 then
          ret.change = false
          ret.frame = 0
        end
      end
    end
  end
  return ret
end

function Sprites:change(name)
  for a = 1, #self.animList do
    if self.animList[a].name == name then
      self.currentAnim = a
      break
    end
  end
end

function Sprites:reset()
  self.frame = 1
  self.time = 0
end

function findNext(lista, name)
  for a = 1, #lista do
    if lista[a].name == name then
      return a
    end
  end
  return 0
end

function Sprites:draw(x, y, r, sx, sy, px, py)
  --[[
    x,y coordenadas de dibujo
    r rotacion (radianes)
    sx escala x (-1 para voltear horizontal)
    sy escala y (-1 para voltear vertical)
    px offset origen x (para definir punto de origen)
      para voltear imagen lo correcto seria sx -1 y px el ancho del sprite / 2
    py offset origen y
      aplica el mismo principio que px, aunque podria ser 0 sin problema
      a no ser que se quiera aplicar escala en y -1
      se utilizaria offset en y solo si el objeto esta ligado a un body de physics
  ]]--
  r = r or 0
  sx = sx or 1
  sy = sy or 1
  px = px or 0
  py = py or 0
  local quad = self.quads[self.currentAnim][self.frame]
  love.graphics.draw(self.img, quad, x, y, r, sx, sy, px, py)
end

return Sprites