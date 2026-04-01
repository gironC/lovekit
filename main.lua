e = require('engine.core.lovekey')

function love.load()
  e:start(800, 450)
end

function love.update(dt)
  e:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
  e:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
  e:keyreleased(key, scancode)
end

function love.mousepressed(x, y , button, istouch, presses)
  e:mousepressed(x, y , button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
  e:mousereleased(x, y, button, istouch, presses)
end

function love.draw()
  e:draw()
end

function love.resize(w, h)
  e:resize(w, h)
end