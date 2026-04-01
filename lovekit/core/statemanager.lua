local StateManager = {}
StateManager.__index = StateManager

StateManager.new = function()
  local self = setmetatable({}, StateManager)
  self.current = nil
  return self
end


function StateManager:change(name)
  if self.current then
    if self.current.leave then self.current:leave() end
  end
  
  local scene = require('game.scenes.' .. name)
  self.current = scene

  if self.current.enter then self.current:enter() end
end

function StateManager:update(dt)
  if self.current and self.current.update then
    self.current:update(dt)
  end
end

function StateManager:keypressed(key, scancode, isrepeat)
  if self.current and self.current.keypressed then
    self.current:keypressed(key, scancode, isrepeat)
  end
end

function StateManager:keyreleased(key, scancode)
  if self.current and self.current.keyreleased then
    self.current:keyreleased(key, scancode)
  end
end

function StateManager:mousepressed(x, y, button, istouch, presses)
  if self.current and self.current.mousepressed then
    self.current:mousepressed(x, y, button, istouch, presses)
  end
end

function StateManager:mousereleased(x, y, button, istouch, presses)
  if self.current and self.current.mousereleased then
    self.current:mousereleased(x, y, button, istouch, presses)
  end
end

function StateManager:draw()
  if self.current and self.current.draw then
    self.current:draw()
  end
end

return StateManager