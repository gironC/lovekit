local Title = {}

function Title:enter()
  print('change to Title scene')
end

function Title:leave()
  print('leaving title scene')
end

function Title:update(dt)
  --update code
end

function Title:mousereleased(x, y, button, istouch, presses)
  e.state:change('game')
end

function Title:draw()
  
  love.graphics.setBackgroundColor(0.4, 0.4, 0.4)
  love.graphics.printf('Welcome to LöveKit\nIf u want to edit this scene go to game/scenes/title.lua', 0, 0, e.camera.vW, 'center')
  love.graphics.printf('Click to change to game scene, with a fade transition of 0.3 seconds.', 0, 28, e.camera.vW, 'center')
  love.graphics.draw(e.assets.image('title'), 50, 50)
end

return Title