# 🧡 LöveKit

> A simple and opinionated framework for building games with LÖVE.

LöveKit is a lightweight framework built on top of LÖVE that helps you structure your game with a clean architecture, without getting in your way.

---

# 🚀 Getting Started

### 1. Create a new project

Use this repository as a template or clone it:

```bash
git clone https://github.com/gironC/lovekit
```

---

### 2. Run with LÖVE

```bash
love .
```
or with console

```bash
lovec .
```

---

### 3. Project structure

```
lovekit/        → core of LöveKit
game/
  scenes/      → your scenes
  assets/      → images, audio, etc.
main.lua       → entry point
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

return Title
```

---

### 5. Start the engine

```lua
function love.load()
  e:start(800, 450)
  e.state:change("title")
end
```

---

# 🎮 Scenes

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

# 🎹 Input

LöveKit provides an input manager.

## Recommended usage:

```lua
function Scene:update(dt)
  if e.input:wasPressed("jump") then
    print("Jump!")
  end
end
```

## Bindings

```lua
e.input.bindings = {
  jump = {"space", "w"}
}
```

## Notes

- Use `e.input` for gameplay logic  
- You can still use `scene:keypressed` if needed  

---

# 🖼️ Assets

All assets must be inside:

```
game/assets/
```

## Load assets

```lua
e.assets.loadImage("player", "imgs/player.png")
```

## Use assets

```lua
local img = e.assets.image("player")
love.graphics.draw(img, x, y)
```

---

# 🎥 Camera

LöveKit uses a **virtual resolution system**.

## Setup

```lua
e:start(800, 450)
```

## Usage

```lua
e.camera:push()

-- draw your game here

e.camera:pop()
```

## Features

- automatic scaling  
- aspect ratio preservation  
- letterboxing  
- mouse world coordinates  

---

# ⏱️ Timer

Example:

```lua
e.timer:every("example", 1, function()
  print("Every second")
end)
```

## Notes

- Uses IDs to prevent duplication  
- Safe to call multiple times  

---

# 🎞️ Sprites

LöveKit provides a simple sprite system for handling sprite sheets and animations.

---

## Create a sprite

```lua
local img = e.assets.image("player")

local sprite = Sprites.new(
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

---

## Update sprite

```lua
sprite:update(dt)
```

- Handles frame changes automatically  
- Uses `delay` to control animation speed  

---

## Draw sprite

```lua
sprite:draw(x, y)
```

### Advanced usage:

```lua
sprite:draw(x, y, r, sx, sy, px, py)
```

Parameters:

- `x, y` → position  
- `r` → rotation (radians)  
- `sx, sy` → scale (use `-1` to flip)  
- `px, py` → origin offset  

---

## Change animation

```lua
sprite:change("run")
```

---

## Reset animation

```lua
sprite:reset()
```

---

## Animation structure

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

---

## Notes

- Sprite sheets are divided automatically into quads  
- Animations are row-based  
- Frame control is handled internally  
- Safe to call `update` every frame  

---

# 🧩 Philosophy

LöveKit follows a simple idea:

> **Structure over complexity**

- Opinionated but flexible  
- Minimal setup  
- Clear architecture  
- Easy to scale  

---

# 📌 Notes

- Use `game/` for your game code  
- Keep `engine/` untouched  
- Prefer using LöveKit systems over raw LÖVE when possible  

---