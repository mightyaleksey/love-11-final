Player = Class{__includes = Vehicle}

function Player:init(skin, x, y, map)
  Vehicle.init(self, skin, x, y)

  self.speed = PLAYER_SPEED
  self.stateMachine = StateMachine {
    ['drive'] = function () return PlayerDriveState(self) end,
    ['turnLeft'] = function () return VehicleTurnLeftState(self) end,
    ['turnRight'] = function () return VehicleTurnRightState(self) end,
  }
  self.stateMachine:change('drive')

  self.map = map
end