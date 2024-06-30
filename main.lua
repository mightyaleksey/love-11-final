require 'dependencies'

function love.load()
  love.window.setTitle('Taxi Driver')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  math.randomseed(os.time())

  -- assets
  gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/font.ttf', 48),
  }
  gTextures = {
    ['bgFail'] = love.graphics.newImage('graphics/bg-fail.png'),
    ['bgStart'] = love.graphics.newImage('graphics/bg-start.png'),
    ['bgSuccess'] = love.graphics.newImage('graphics/bg-success.png'),
    ['modernCity'] = love.graphics.newImage('graphics/tilemap-modern-city.png'),
    ['urban'] = love.graphics.newImage('graphics/tilemap-urban.png')
  }
  gFrames = {
    ['modernCity'] = genQuads(gTextures['modernCity'], 16, 16),
    ['grass'] = genQuads(gTextures['modernCity'], 16, 16, 0, 400, 320, 448),
    ['passangers'] = genQuads(gTextures['urban'], 16, 16, 368, 0, 432, 288),
    ['road'] = genQuads(gTextures['modernCity'], 16, 16, 144, 304, 240, 400),
    ['surface'] = genQuads(gTextures['modernCity'], 16, 16, 0, 384, 144, 400),
    ['tiles'] = genQuads(gTextures['modernCity'], 16, 16, 0, 304, 144, 384),
    ['vehicle'] = genVehicleQuads(gTextures['modernCity']),
  }

  push:setupScreen(
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
    WINDOW_WIDTH, WINDOW_HEIGHT,
    { vsync = true, fullscreen = false, resizable = true }
  )

  -- register key aliases
  Keys.setAlias('down', 's')
  Keys.setAlias('left', 'a')
  Keys.setAlias('right', 'd')
  Keys.setAlias('up', 'w')

  gSounds = {
    ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
    ['door'] = love.audio.newSource('sounds/door.wav', 'static'),
    ['kill'] = love.audio.newSource('sounds/kill.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
    ['turn'] = love.audio.newSource('sounds/turn.wav', 'static'),
    ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
  }
  gStateStack = StateStack()
  gStateStack:push(GameStartState())

  gSounds['music']:setLooping(true)
  gSounds['music']:play()
end

function love.draw()
  push:start()
  gStateStack:render()
  push:finish()
end

-- [[ state & IO updates ]]

function love.keypressed(key)
  Keys.keypressed(key)
end

function love.keyreleased(key)
  Keys.keyreleased(key)
end

function love.update(dt)
  gStateStack:update(dt)
  Timer.update(dt)
  Keys.update(dt)
end