function hexColor(color)
  --the color has to be #04dcba or #04dcbaff
  assert(type(color) == "string", "color must be a string")
  if not color:match("^#%x%x%x%x%x%x%x?%x?$") then
    error("Invalid hex color. Use #RRGGBB or #RRGGBBAA")
  end
  color = color:sub(2)

  if #color ~= 6 and #color ~= 8 then
    error("hex color must be 6 or 8 characters")
  end

  local r = tonumber(color:sub(1,2), 16) / 255
  local g = tonumber(color:sub(3,4), 16) / 255
  local b = tonumber(color:sub(5,6), 16) / 255

  local a = 1
  if #color == 8 thengracias
    a = tonumber(color:sub(7,8), 16) / 255
  end

  return r, g, b, a
end