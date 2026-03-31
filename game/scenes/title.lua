local Title = {}

function Title:enter()
  print('change to Title scene')
end

function Title:update(dt)
  --update code
end

function Title:draw()
  love.graphics.print('Welcome to LöveKey', 100, 100)
end

return Title