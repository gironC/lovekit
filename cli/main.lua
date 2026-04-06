local args = {...}

local command = args[1]

if not command then
  print('command is missing, use "./lovekit help" for display command list')
  return
end

if command == 'create-scene' then
  require('cli.create-scene')(args)
elseif command == 'create-entity' then
  require('cli.create-entity')(args)
else
  print(command .. ' is not a know command')
end