local stateManager = require('lovekit.core.statemanager')
local transition = require('lovekit.core.transitionmanager')
local camera = require('lovekit.modules.camera')
local timer = require('lovekit.modules.timer')

local LoveKit = {}

function LoveKit:start(props)
  props = props or {}

  self.collider = require('lovekit.modules.collision') 
  self.assets = require('lovekit.modules.assets')
  self.input = require('lovekit.modules.inputmanager')
  --default resolution to 800 x 600
  self.vWidth = props.width or 800
  self.vHeight = props.height or 600
  self.camera = camera.new(self.vWidth, self.vHeight)
  self.camera:resize(love.graphics.getWidth(), love.graphics.getHeight())
  local transition = props.transition or {mode = 'none'}
  if transition.imageName and transition.imageType then
    local file = transition.imageName .. transition.imageType
    local id = transition.imageName
    self.assets.loadImage(id, file)
    transition.img = self.assets.image(id)
  end
  if transition.mode == 'anim' then
    transition.w = self.vWidth
    transition.h = self.vHeight
  end
  self.state = stateManager.new(transition)
  self.timer = timer.new()
end

function LoveKit:update(dt)
  self.camera:update(dt)
  self.timer:update(dt)
  self.state:update(dt, self.camera)
  self.input.keysPressed = {}
  self.input.keysReleased = {}
end

function LoveKit:keypressed(key, scancode, isrepeat)
  self.input.keypressed(key)
  self.state:keypressed(key, scancode, isrepeat)
end

function LoveKit:keyreleased(key, scancode)
  self.input.keyreleased(key)
  self.state:keyreleased(key, scancode)
end

function LoveKit:mousepressed(x, y, button, istouch, presses)
  self.state:mousepressed(x, y, button, istouch, presses)
end

function LoveKit:mousereleased(x, y, button, istouch, presses)
  self.state:mousereleased(x, y, button, istouch, presses)
end

function LoveKit:draw()
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

function LoveKit:resize(w, h)
  self.camera:resize(w, h)
end

return LoveKit