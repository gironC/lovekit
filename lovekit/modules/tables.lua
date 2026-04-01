function tFindValue(table, value, order)
  --order 'a' asc 'd' desc
  local index = 0
  if order == 'a' then
    for a = 1, #table do
      if table[a] == value then
        index = a
        return index
      end
    end
  else
    for a = #table, 1, -1 do
      if table[a] == value then
        index = a
        return index
      end
    end
  end
  return index
end

function tFindObjectValue(table, prop, value, order)
  --order 'a' asc 'd' desc
  local index = 0
  if order == 'a' then
    for a = 1, #table do
      if table[a][prop] == value then
        index = a
        return index
      end
    end
  else
    for a = #table, 1, -1 do
      if table[a][prop] == value then
        index = a
        return index
      end
    end
  end
  return index
end