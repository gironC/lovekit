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
  love.graphics.printf('Welcome to LöveKey\nIf u want to edit this scene go to game/scenes/title.lua', 0, 0, e.camera.vW, 'center')
end

return Title