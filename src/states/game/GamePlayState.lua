GamePlayState = Class{__includes = BaseState}

function GamePlayState:init(level)
  self.map = Map(level)
  self.player = Player(
    'vehicleOrange',
    self.map:getStartX() - TILE_SIZE,
    self.map:getStartY(),
    self.map
  )
end

function GamePlayState:enter()
  gStateStack:push(PickUpState(self))
end

function GamePlayState:render()
  -- reset color
  love.graphics.setColor(1, 1, 1, 1)
  -- emulate camera effect
  -- (works like applying dx, dy to subsequent rendered objects)
  love.graphics.translate(0, -round(self.map.scrollY))

  self.map:render()
  self.player:render()

  love.graphics.translate(0, round(self.map.scrollY))
end

function GamePlayState:update(dt)
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  -- shift camera according to the player position
  self.map.scrollY = self.map.scrollY - self.player.speed * dt

  self.map:update(dt)
  self.map:genTraffic()
  self.player:update(dt)

  for _, entity in ipairs(self.map.entities) do
    if collides(entity, self.player) then
      -- game over
      self:accident()
    end
  end

  if self.map:getRemainingDistance() < 2 then
    gStateStack:push(DepartState(self))
  end
end

-- [[ helpers ]]

function GamePlayState:accident()
  gSounds['kill']:play()

  gStateStack:push(TransitionState {
    animation = 'fadeIn',
    onComplete = function ()
      -- remove self
      gStateStack:pop()
      gStateStack:push(GameEndState(false))
      gStateStack:push(TransitionState {
        animation = 'fadeOut'
      })
    end,
  })
end