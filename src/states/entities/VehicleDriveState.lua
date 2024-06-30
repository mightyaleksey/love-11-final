VehicleDriveState = Class{__includes = BaseState}

function VehicleDriveState:init(entity)
  assert(entity)
  self.entity = entity
end

function VehicleDriveState:enter()
  self.entity:changeAnimation('drive-'..self.entity.direction)

  self.entity.offsetX = 0
  self.entity.offsetY = 0
end

function VehicleDriveState:update(dt)
  local direction = self.entity.direction

  if direction == 'top' then
    self.entity.y = self.entity.y - self.entity.speed * dt
  elseif direction == 'bottom' then
    self.entity.y = self.entity.y + self.entity.speed * dt
  end
end