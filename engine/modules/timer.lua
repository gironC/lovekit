local Timer = {}
Timer.__index = Timer

Timer.new = function()
  local self = setmetatable({}, Timer)
  self.tareas = {}
  self.diccionario = {}
  return self
end

function Timer:after(id, tiempo, fn)
  if self.diccionario[id] then return end
  local tarea = {
    tiempo = tiempo,
    fn = fn,
    cont = 0,
    loop = false,
    pausa = false,
    id = id
  }

  table.insert(self.tareas, tarea)
  self.diccionario[id] = true --se le pone true para saber que el campo esta ocupado y ya
end

function Timer:every(id, tiempo, fn)
  if self.diccionario[id] then return end
  local tarea = {
    tiempo = tiempo,
    fn = fn,
    cont = 0,
    loop = true,
    pausa = false,
    id = id
  }

  table.insert(self.tareas, tarea)
  self.diccionario[id] = true --se le pone true para saber que el campo esta ocupado y ya
end

function Timer:exists(id)
  return self.diccionario[id] ~= nil
end

function Timer:clear()
  self.tareas = {}
  self.diccionario = {}
end

function Timer:cancel(id)
  if self.diccionario[id] then
    for a = #self.tareas, 1, -1 do
      if self.tareas[a].id == id then
        self.diccionario[id] = nil
        table.remove(self.tareas, a)
        break
      end
    end
    return true
  else
    return false
  end
end

function Timer:reset(id)
  local tarea = self:_find(id)
  if tarea then
    tarea.cont = 0
    return true
  else
    return false
  end
end

function Timer:pause(id)
  local tarea = self._find(id)
  if tarea then
    tarea.pausa = true
    return true
  else
    return false
  end
end

function Timer:resume(id)
  local tarea = self._find(id)
  if tarea then
    tarea.pausa = false
    return true
  else
    return false
  end
end

function Timer:update(dt)
  for a = #self.tareas, 1, -1 do
    local tarea = self.tareas[a]
    if not tarea.pausa then
      tarea.cont = tarea.cont + dt
      if tarea.cont >= tarea.tiempo then
        tarea.fn()
        if tarea.loop then
          tarea.cont = 0
        else
          self.diccionario[tarea.id] = nil
          table.remove(self.tareas, a)
        end
      end
    end
  end
end

function Timer:_find(id)
  for a = #self.tareas, 1, -1 do
    if self.tareas[a].id == id then
      return self.tareas[a]
    end
  end
  return nil
end

return Timer