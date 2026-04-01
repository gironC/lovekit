e = require('lovekit.core.main')

function love.load()
  e:start(800, 450)
  --[[
    all the scenes must be saved in game/scenes, and in the :change function
    the name must match with the file name, in this case the first scene
    is Title scene, wich is saved in game/scenes/title.lua
  ]]--
  e.state:change('title')
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