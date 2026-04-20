e = require('lovekit.core.main')

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  --[[
    all the scenes must be saved in game/scenes, and in the :change function
    the name must match with the file name, in this case the first scene
    is Title scene, wich is saved in game/scenes/title.lua
  ]]--
  
  --initialize lovekit
  e:start({
    width = 400,
    height = 300,
    transition = {
      mode = 'anim',
      duration = .4,
      imageName = 'transitionanim', --in this case, the id will be 'transition'
      imageType = '.png', -- the image will be transition.png, using the id given in image
      frames = 8
    }
  })
  --add assets example
  e.assets.loadImage('title', 'title.png')
  --input manager example
  e.input.bind('example', {'a', 'A', 'left'})
  --find game/scenes/title.lua file to load that scene
  e.state:setFirstScene('title')
end

function love.update(dt)
  --use the update function in the current scene, this apply for other love. functions
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