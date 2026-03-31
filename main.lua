Engine = require('engine.core.lovekey')

function love.load()
  Engine:start(800, 450)
end

function love.update(dt)
  Engine:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
  Engine:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
  Engine:keyreleased(key, scancode)
end

function love.mousepressed(x, y , button, istouch, presses)
  Engine:mousepressed(x, y , button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
  Engine:mousereleased(x, y, button, istouch, presses)
end

function love.draw()
  Engine:draw()
end

function love.resize(w, h)
  Engine:resize(w, h)
end