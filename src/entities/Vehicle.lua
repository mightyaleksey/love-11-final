Vehicle = Class{__includes = Entity}

function Vehicle:init(skin, x, y)
  assert(EntityDefinitions[skin])
  self.skin = skin

  Entity.init(self, {
    -- from definition
    width = EntityDefinitions[self.skin].width,
    height = EntityDefinitions[self.skin].height,
    interval = EntityDefinitions[self.skin].interval,
    speed = VEHICLE_SPEED,

    frames = EntityDefinitions[self.skin].frames,
    texture = EntityDefinitions[self.skin].texture,

    animations = EntityDefinitions[self.skin].animations,

    -- from input
    x = x or 0,
    y = y or 0,
  })

  self.stateMachine = StateMachine {
    ['drive'] = function () return VehicleDriveState(self) end,
    ['turnLeft'] = function () return VehicleTurnLeftState(self) end,
    ['turnRight'] = function () return VehicleTurnRightState(self) end,
  }
  self.stateMachine:change('drive')
end