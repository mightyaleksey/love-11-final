Entity = Class{}

function Entity:init(opt)
  -- dimensions
  self.width = opt.width
  self.height = opt.height
  self.x = opt.x
  self.y = opt.y

  -- textures
  self.frames = opt.frames
  self.texture = opt.texture
  self.offsetX = 0
  self.offsetY = 0

  -- attributes
  self.animations = self:genAnimations(opt.animations, opt.interval)
  self.currentAnimation = nil
  self.direction = 'top'
  self.currentSpeed = 0
  self.speed = opt.speed
  self.stateMachine = nil

  -- internal states
  self.inPlay = true
end

function Entity:render()
  local animation = self.currentAnimation

  love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.frames][animation:getCurrentFrame()],
    math.floor(self.x + self.offsetX),
    math.floor(self.y + self.offsetY)
  )
end

function Entity:update(dt)
  self.stateMachine:update(dt)

  if self.currentAnimation then
    self.currentAnimation:update(dt)
  end
end

-- [[ helpers ]]

function Entity:changeAnimation(name)
  assert(self.animations[name])
  self.currentAnimation = self.animations[name]
end

function Entity:changeDirection(direction)
  self.direction = direction
  self.stateMachine.current:enter()
end

function Entity:changeState(name, values)
  self.stateMachine:change(name, values)
end

function Entity:genAnimations(animations, defaultInterval)
  assert(animations)
  local animationList = {}

  for k, opt in pairs(animations) do
    animationList[k] = Animation {
      frames = opt.frames,
      interval = opt.interval or defaultInterval,
    }
  end

  return animationList
end