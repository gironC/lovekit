local Assets = {}

Assets.images = {}
Assets.audios = {}
--futuro videos
Assets.videos = {}

--imagenes
function Assets.loadImage(id, name)
  print(id)
  print('name' .. name)
  Assets.images[id] = love.graphics.newImage('game/assets/' .. name)
end

function Assets.image(id)
  if Assets.images[id] then
    return Assets.images[id]
  else
    error('Image not found: ' .. id)
  end
end

--audios
function Assets.loadAudio(id, name, audioType)
  Assets.audios[id] = love.audio.newSource('game/assets/' .. name, audioType)
end

function Assets.audio(id)
  if Assets.audios[id] then
    return Assets.audios[id]
  else
    error('Audio not found: ' .. id)
  end
end

function Assets.play(id)
  Assets.audios[id]:stop()
  Assets.audios[id]:play()
end

function Assets.volume(id, volume)
  Assets.audios[id]:setVolume(volume)
end

function Assets.pitch(id, pitch)
  Assets.audios[id]:setPitch(pitch)
end

--videos (futuro)

--control
function Assets.clear()
  Assets.images = {}
  Assets.audios = {}
  Assets.videos = {}
end

return Assets