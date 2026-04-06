-- entity generated with template

local {{Entity}} = {}
{{Entity}}.__index = {{Entity}}

--local Hitbox = require('lovekit.modules.hitbox')

function {{Entity}}:new(x, y, w, h)
  local self = setmetatable({}, {{Entity}})
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  --self.img = e.assets.image('image.png')
  --self.hitbox = Hitbox:new(x, y, w, h, offsetX, offsetY)
  return self
end

function {{Entity}}:update(dt)
  --update code
end

function {{Entity}}:draw()
  --draw code
end

return {{Entity}}