local TransitionManager = {}
TransitionManager.__index = TransitionManager

TransitionManager.new = function(transition, duration)
  local self = setmetatable({}, TransitionManager)
  self.transition = transition
  self.duration = duration
  if transition == 'none' then self.duration = 0 end
  self.count = 0
  self.state = 0 -- 0 none, 1 in, 2 change, 3 out
  self.alpha = 0
  self.x = 0
  return self
end


function TransitionManager:begin()
  self.count = 0
  self.state = 1
end

function TransitionManager:changeState(state)
  self.count = 0
  self.state = state
end

function TransitionManager:update(dt)
  if self.state == 1 or self.state == 3 then
    self.count = self.count + dt
    if self.transition == 'fade' then self:_updateFade(dt) end
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

function TransitionManager:_updateSlideR(dt)
end

function TransitionManager:_updateSlideL(dt)
end

function TransitionManager:_updateAnim(dt)
end

function TransitionManager:draw(vw, vh)
  if self.state == 0 then return end
  love.graphics.setColor(0, 0, 0, self.alpha)
  love.graphics.rectangle('fill', 0, 0, vw, vh)
end

return TransitionManager