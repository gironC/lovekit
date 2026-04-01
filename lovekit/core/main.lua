local stateManager = require('lovekit.core.statemanager')
local camera = require('lovekit.modules.camera')
local timer = require('lovekit.modules.timer')
local sprites = require('lovekit.modules.sprites')

local LoveKey = {}

function LoveKey:start(vWidth, vHeight)
  self.state = stateManager.new()
  self.camera = camera.new(vWidth, vHeight)
  self.camera:resize(love.graphics.getWidth(), love.graphics.getHeight())
  self.timer = timer.new()
end

function LoveKey:update(dt)
  self.state:update(dt)
  self.camera:update(dt)
  self.timer:update(dt)
end

function LoveKey:keypressed(key, scancode, isrepeat)
  self.state:keypressed(key, scancode, isrepeat)
end

function LoveKey:keyreleased(key, scancode)
  self.state:keyreleased(key, scancode)
end

function LoveKey:mousepressed(x, y, button, istouch, presses)
  self.state:mousepressed(x, y, button, istouch, presses)
end

function LoveKey:mousereleased(x, y, button, istouch, presses)
  self.state:mousereleased(x, y, button, istouch, presses)
end

function LoveKey:draw()
  self.camera:push()
  self.state:draw()
  self.camera:pop()
end

function LoveKey:resize(w, h)
  self.camera:resize(w, h)
end

return LoveKey