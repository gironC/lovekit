local Game = {}

function Game:enter()
  print('change to Game scene')
end

function Game:leave()
  print('leaving Game scene')
end

function Game:update(dt)
  --update code
end

function Game:draw()
  love.graphics.printf('This is the game scene, for edit this go to\ngame/scenes/game.lua', 0, 0, e.camera.vW, 'center')
end

return Game