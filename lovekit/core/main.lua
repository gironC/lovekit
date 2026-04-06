local stateManager = require('lovekit.core.statemanager')
local camera = require('lovekit.modules.camera')
local timer = require('lovekit.modules.timer')

local LoveKey = {}

function LoveKey:start(props)
  if props then
    self.vWidth = props.width or 800
    self.vHeight = props.height or 600
  end
  self.state = stateManager.new()
  self.camera = camera.new(self.vWidth, self.vHeight)
  self.camera:resize(love.graphics.getWidth(), love.graphics.getHeight())
  self.timer = timer.new()
  self.collider = require('lovekit.modules.collision') 
  self.assets = require('lovekit.modules.assets')
  self.input = require('lovekit.modules.inputmanager')
end

function LoveKey:update(dt)
  self.state:update(dt)
  self.camera:update(dt)
  self.timer:update(dt)
  self.input.keysPressed = {}
  self.input.keysReleased = {}
end

function LoveKey:keypressed(key, scancode, isrepeat)
  self.input.keypressed(key)
  self.state:keypressed(key, scancode, isrepeat)
end

function LoveKey:keyreleased(key, scancode)
  self.input.keyreleased(key)
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