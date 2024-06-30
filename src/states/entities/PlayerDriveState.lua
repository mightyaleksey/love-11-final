PlayerDriveState = Class{__includes = VehicleDriveState}

function PlayerDriveState:init(entity)
  VehicleDriveState.init(self, entity)
end

function PlayerDriveState:enter()
  VehicleDriveState.enter(self)
end

function PlayerDriveState:exit()
  VehicleDriveState.exit(self)
end

function PlayerDriveState:update(dt)
  VehicleDriveState.update(self, dt)

  local map = self.entity.map

  if
    Keys.wasHolding('left') and
    self.entity.x > map.leftRoadX
  then
    self.entity:changeState('turnLeft')
  elseif
    Keys.wasHolding('right') and
    self.entity.x + 2 * TILE_SIZE < map.rightRoadX
  then
    self.entity:changeState('turnRight')
  end
end