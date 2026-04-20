local TransitionManager = {}
TransitionManager.__index = TransitionManager

TransitionManager.new = function(props)
  local self = setmetatable({}, TransitionManager)
  self.mode = props.mode or 'none'
  self.duration = props.duration or 0
  self.count = 0
  self.state = 0 -- 0 none, 1 in, 2 change, 3 out
  --fade props
  self.alpha = 0
  --slides props
  self.x = 0
  --image props
  self.img = props.img or nil
  if self.mode == 'anim' then
    local frames = props.frames or 4
    local delay = self.duration / frames
    local animations = {
      {name = 'in', frames = frames, delay = delay, loop = false, nextAnim = 'out'},
      {name = 'out', frames = frames, delay = delay, loop = false, nextAnim = 'out'}
    }
    self.sprites = require('lovekit.modules.sprites'):new(self.img, 2, props.frames or 4, props.w, props.h, animations)
  end
  return self
end


function TransitionManager:begin()
  self.count = 0
  self.state = 1
  self.alpha = 0
  self.x = 0
  if self.mode == 'anim' then
    self.sprites:reset()
    self.sprites:change('in')
  end
end

function TransitionManager:changeState(state)
  self.count = 0
  self.state = state
end

function TransitionManager:update(dt, camera)
  if self.state == 1 or self.state == 3 then
    self.count = self.count + dt
    if self.mode == 'fade' then self:_updateFade(dt)
    elseif self.mode == 'slideR' then self:_updateSlideR(dt, camera)
    elseif self.mode == 'slideL' then self:_updateSlideL(dt, camera)
    elseif self.mode == 'anim' then self:_updateAnim(dt)
    end
    if self.count >= self.duration then
      self.count = 0
      self.state = self.state + 1
      if self.state > 3 then self.state = 0 end
    end
  end
end

function TransitionManager:_updateFade(dt)
  if self.state == 1 then self.alpha = math.min(self.count / self.duration, 1)
  else self.alpha = 1 - math.min(self.count / self.duration, 1) end
end
 
function TransitionManager:_updateSlideR(dt, camera)
  if self.state == 1 then self.x = -camera.vW * (1 - math.min(self.count / self.duration, 1))
  elseif self.state == 3 then self.x = camera.vW * math.min(self.count / self.duration, 1) end
end

function TransitionManager:_updateSlideL(dt, camera)
  if self.state == 1 then self.x = camera.vW * (1 - math.min(self.count / self.duration, 1))
  elseif self.state == 3 then self.x = -camera.vW * math.min(self.count / self.duration, 1) end
end

function TransitionManager:_updateAnim(dt)
  self.sprites:update(dt)
end

function TransitionManager:draw(vw, vh)
  if self.state == 0 then return end
  if self.mode == 'fade' then
    if self.img then
      love.graphics.setColor(1, 1, 1, self.alpha)
      love.graphics.draw(self.img, 0, 0)
    else
      love.graphics.setColor(0, 0, 0, self.alpha)
      love.graphics.rectangle('fill', 0, 0, vw, vh)
    end
  elseif self.mode == 'slideR' or self.mode == 'slideL' then
    if self.img then
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(self.img, self.x, 0)
    else
      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.rectangle('fill', self.x, 0, vw, vh)
    end
  elseif self.mode == 'anim' then
    love.graphics.setColor(1, 1, 1, 1)
    self.sprites:draw(0, 0)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

return TransitionManager