# LöveKit

> A simple and opinionated framework for building games with LÖVE.

LöveKit is a lightweight framework built on top of LÖVE that helps you structure your game with a clean architecture, without getting in your way.

---

## Features

- Scene system
- Virtual resolution camera
- Input manager
- Asset manager
- Timer utilities
- Sprite animations
- Scene transitions
- CLI generators

---

## Getting Started

### 1. Create a new project

Use this repository as a template.

---

### 2. Run with LÖVE

```bash
love .
```
or with console

```bash
lovec .
```

or just create your .zip or .love file to open with löve manually

---

### 3. Project structure

```
lovekit/        → core of LöveKit
game/
  scenes/      → your scenes
  entities/    → your entities like player, enemy, etc.
  assets/      → images, audio, etc.
main.lua       → entry point
conf.lua       → Löve configuration file
```

---

### 4. First scene

Scenes live inside:

```
game/scenes/
```

Example:

```lua
local Title = {}

function Title:enter()
  print("Entered Title scene")
end

function Title:update(dt)
end

function Title:draw()
  love.graphics.print("Hello LöveKit", 10, 10)
end

function Title:mousepressed(x, y, button, istouch, presses)
  if button == 2 then
    e.state:change("game")
  end
end

return Title
```

---

### 5. Start the engine

```lua
function love.load()
  e:start({
    width = 800,
    height = 450
  })
  e.state:setFirstScene('title')
end
```

---

## Core components

### Scenes

Each scene can implement:

```lua
function Scene:enter() end
function Scene:leave() end
function Scene:update(dt) end
function Scene:draw() end
```

Optional input callbacks:

```lua
function Scene:keypressed(key, scancode, isrepeat) end
function Scene:keyreleased(key, scancode) end
function Scene:mousepressed(x, y, button, istouch, presses) end
function Scene:mousereleased(x, y, button, istouch, presses) end
```

---

### Input

LöveKit provides an input manager.

#### Recommended usage:

```lua
function Scene:update(dt)
  if e.input:wasPressed("jump") then
    print("Jump!")
  end
end
```

#### Bindings

```lua
e.input.bind('jump', {'w', 'W', 'space'})
```

#### Notes

- Use `e.input` for gameplay logic  
- You can still use `scene:keypressed` if needed  

---

### Assets

All assets must be inside:

```
game/assets/
```

#### Load assets

```lua
e.assets.loadImage("player", "imgs/player.png") --for images
e.assets.loadAudio('jump', 'jump.wav', 'static') --for audios
```

#### Use assets

```lua
local img = e.assets.image("player")
love.graphics.draw(img, x, y)

local jump = e.assets.audio('jump')
jump.play()
```


---

### Camera

LöveKit uses a **virtual resolution system**.

#### Setup

```lua
e:start({
  width = 800,
  height = 450
})
```

This will be the virtual resolution, it will adapt to the real window size.

#### Usage

Everything drawn inside a scene `:draw()` is rendered through the camera automatically. Also You can configure a target to follow with:

```lua
e.camera:setTarget(player) --player needs to be an entity
e.camera:setSmooth(true, .5) --set false if you want to deactivate smooth, the .5 is the time
```

#### Features

- automatic scaling  
- aspect ratio preservation  
- letterboxing  
- mouse world coordinates  

---

### Timer

Example:

```lua
e.timer:every("example", 1, function()
  print("Every second")
end)
```

#### Notes

- Uses IDs to prevent duplication  
- Safe to call multiple times  

---

### Sprites

LöveKit provides a simple sprite system for handling sprite sheets and animations.

---

#### Create a sprite

```lua
local Sprites = require('lovekit.modules.sprites')

local img = e.assets.image("player")

local sprite = Sprites:new(
  img,
  2,      -- rows
  4,      -- cols
  32,     -- frame width
  32,     -- frame height
  {
    { name = "idle", frames = 4, delay = 0.2, loop = true },
    { name = "run", frames = 4, delay = 0.1, loop = true }
  }
)
```


#### Update sprite

```lua
sprite:update(dt)
```

- Handles frame changes automatically  
- Uses `delay` to control animation speed  



#### Draw sprite

```lua
sprite:draw(x, y)
```

Advanced usage:

```lua
sprite:draw(x, y, r, sx, sy, px, py)
```

Parameters:

- `x, y` → position  
- `r` → rotation (radians)  
- `sx, sy` → scale (use `-1` to flip)  
- `px, py` → origin offset  


#### Change animation

```lua
sprite:change("run")
```

#### Reset animation

```lua
sprite:reset()
```

#### Animation structure

Each animation is defined as:

```lua
{
  name = "run",
  frames = 4,
  delay = 0.1,
  loop = true,
  nextAnim = "idle" -- optional
}
```

- `name` → animation name  
- `frames` → number of frames  
- `delay` → time between frames  
- `loop` → should repeat  
- `nextAnim` → next animation if not looping  


#### Notes

- Sprite sheets are divided automatically into quads  
- Animations are row-based  
- Frame control is handled internally  
- Safe to call `update` every frame  

---

### Scene Transitions

Transitions are configured when starting the engine.

#### Basic example

Configure transitions inside `:start()`.

```lua
e:start({
  width = 400,
  height = 300,
  transition = {
    mode = "fade",
    duration = 0.4
  }
})
```

#### Disable transitions

```lua
e:start({
  width = 400,
  height = 300,
  transition = {
    mode = "none",
  }
})
```

Or simply omit the `transition` config.

#### Transition Types

- `none`
- `fade`
- `slideR`
- `slideL`
- `anim`

`fade`, `slideR` and `slideL` can use an image instead of a black screen:

```lua
e:start({
  width = 400,
  height = 300,
  transition = {
    mode = "fade",
    duration = 0.4,
    imageName = "wipe",
    imageType = ".png"
  }
})
```

`anim` uses a spritesheet-based transition.
The first row of the frames are used for the transition in, and the second row for the transition out.

```lua
e:start({
  width = 400,
  height = 300,
  transition = {
    mode = "anim",
    duration = 0.4,
    imageName = "wipe",
    imageType = ".png",
    frames = 4
  }
})
```

---

## CLI
LöveKit includes a small CLI to generate common files quickly.

Use it from the project root:
```bash
./lovekit <command> <name>
```

### Create a Scene
```bash
./lovekit create-scene title
```
Creates:
```bash
game/scenes/title.lua
```

### Create an Entity
```bash
./lovekit create-entity player
```
Creates:
```bash
game/entities/player.lua
```

### Naming convention
It is recommended to use lowercase names.

For multi-word names, use camelCase:
```bash
mainMenu
enemyBoss
playerStats
```

### Notes
- Run commands from the project root.
- Existing files may be overwritten.
- The CLI is optional, but useful for faster workflow.

---

## General notes

- Use `game/` for your game code  
- Keep `lovekit/` untouched  
- Prefer using LöveKit systems over raw LÖVE when possible  

---
