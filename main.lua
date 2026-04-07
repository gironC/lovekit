e = require('lovekit.core.main')

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  --[[
    all the scenes must be saved in game/scenes, and in the :change function
    the name must match with the file name, in this case the first scene
    is Title scene, wich is saved in game/scenes/title.lua
  ]]--
  e:start({
    width = 800,
    height = 450})
  --add assets example
  e.assets.loadImage('title', 'title.png')
  --input manager example
  e.input.bind('example', {'a', 'A', 'left'})
  --find game/scenes/title.lua file to load that scene
  e.state:change('title')
end

function love.update(dt)
  --use the update function in the current scene
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