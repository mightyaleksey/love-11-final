EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
  assert(entity)
  self.entity = entity
  self.entity:changeAnimation('walk-'..self.entity.direction)
end

function EntityWalkState:update(dt)
  local direction = self.entity.direction

  if direction == 'top' then
    self.entity.y = self.entity.y - self.entity.speed * dt
  elseif direction == 'right' then
    self.entity.x = self.entity.x + self.entity.speed * dt
  elseif direction == 'bottom' then
    self.entity.y = self.entity.y + self.entity.speed * dt
  elseif direction == 'left' then
    self.entity.x = self.entity.x - self.entity.speed * dt
  end
end