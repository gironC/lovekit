local stateManager = require('lovekit.core.statemanager')
local transition = require('lovekit.core.transitionmanager')
local camera = require('lovekit.modules.camera')
local timer = require('lovekit.modules.timer')

local LoveKey = {}

function LoveKey:start(props)
  props = props or {}
  --default resolution to 800 x 600
  self.vWidth = props.width or 800
  self.vHeight = props.height or 600
  local transition = props.transition or 'none'
  local transitionDuration = props.transitionDuration or 0
  self.state = stateManager.new(transition, transitionDuration)
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
  love.graphics.clear(0, 0, 0)
  love.graphics.setColor(1, 1, 1, 1)
  self.camera:push()
  self.state:draw()
  self.camera:pop()
  self.camera:screenPush()
  self.state:drawUI()
  self.state:drawTransition(self.camera:getDimensions())
  self.camera:screenPop()
end

function LoveKey:resize(w, h)
  self.camera:resize(w, h)
end

return LoveKey