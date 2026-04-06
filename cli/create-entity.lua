return function(args)
  local name = args[2]

  if not name then
    print('please provide a entity name')
    return
  end

  local path = 'game/entities/' .. name .. '.lua'
  local entityName = name:gsub('^%l', string.upper)
  local file = io.open(path, 'w')
  local template = io.open('cli/templates/entity.lua', 'r'):read('*all')
  template = template:gsub('{{Entity}}', entityName)
  file:write(template)
  file:close()
  print('entity created at' .. path)
  return
end