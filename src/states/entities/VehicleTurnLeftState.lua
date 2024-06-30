VehicleTurnLeftState = Class{__includes = BaseState}

function VehicleTurnLeftState:init(entity)
  assert(entity)
  self.entity = entity
  self.timer = nil
end

function VehicleTurnLeftState:enter()
  self.entity:changeAnimation('drive-'..self.entity.direction)
  gSounds['turn']:stop()
  gSounds['turn']:play()

  self.entity.offsetX = 0
  self.entity.offsetY = 0

  self.timer = Timer.tween(TAKE_TURN_INTERVAL, {
    [self.entity] = {
      x = self.entity.x - TILE_SIZE
    }
  })
  :finish(function ()
    self.timer = Timer.after(TAKE_TURN_DELAY, function ()
      self.entity:changeState('drive')
    end)
  end)
end

function VehicleTurnLeftState:update(dt)
  local direction = self.entity.direction

  if direction == 'top' then
    self.entity.y = self.entity.y - self.entity.speed * dt
  elseif direction == 'bottom' then
    self.entity.y = self.entity.y + self.entity.speed * dt
  end
end