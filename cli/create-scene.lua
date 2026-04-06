return function(args)
  local name = args[2]

  if not name then
    print('please provide a scene name')
    return
  end

  local path = 'game/scenes/' .. name .. '.lua'
  local sceneName = name:gsub('^%l', string.upper)
  local file = io.open(path, 'w')
  local template = io.open('cli/templates/scene.lua', 'r'):read('*all')
  template = template:gsub('{{Scene}}', sceneName)
  file:write(template)
  file:close()
  print('scene created at' .. path)
  return
end