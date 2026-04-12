local StateManager = {}
StateManager.__index = StateManager

StateManager.new = function(transition, duration)
  local self = setmetatable({}, StateManager)
  self.current = nil
  self.transition = require('lovekit.core.transitionmanager').new(transition,duration)
  self.next = ''
  return self
end

function StateManager:setFirstScene(name)
  local scene = require('game.scenes.' .. name)
    self.current = scene
  
    if self.current.enter then self.current:enter() end
end

function StateManager:change(name)
  if self.transition.state == 0 then
    self.next = name
    self.transition:begin()
    return
  end
end

function StateManager:changeScene()
  if self.transition.state == 2 then
    if self.current then
      if self.current.leave then self.current:leave() end
    end
    
    self.transition:changeState(3)
    
    local scene = require('game.scenes.' .. self.next)
    self.current = scene
  
    if self.current.enter then self.current:enter() end

  end
end

function StateManager:update(dt)
  self.transition:update(dt)
  if self.transition.state == 2 then
    self:changeScene()
  end
  if self.current and self.current.update then
    self.current:update(dt)
  end
end

function StateManager:keypressed(key, scancode, isrepeat)
  if self.transition.state > 0 then return end
  if self.current and self.current.keypressed then
    self.current:keypressed(key, scancode, isrepeat)
  end
end

function StateManager:keyreleased(key, scancode)
  if self.transition.state > 0 then return end
  if self.current and self.current.keyreleased then
    self.current:keyreleased(key, scancode)
  end
end

function StateManager:mousepressed(x, y, button, istouch, presses)
  if self.transition.state > 0 then return end
  if self.current and self.current.mousepressed then
    self.current:mousepressed(x, y, button, istouch, presses)
  end
end

function StateManager:mousereleased(x, y, button, istouch, presses)
  if self.transition.state > 0 then return end
  if self.current and self.current.mousereleased then
    self.current:mousereleased(x, y, button, istouch, presses)
  end
end

function StateManager:draw()
  if self.current and self.current.draw then
    self.current:draw()
  end
end

function StateManager:drawUI()
  if self.current and self.current.drawUI then
    self.current:drawUI()
  end
end

function StateManager:drawTransition(vw, vh)
  self.transition:draw(vw, vh)
end

return StateManager