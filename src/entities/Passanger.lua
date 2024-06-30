Passanger = Class{__includes = Entity}

function Passanger:init(skin, x, y)
  assert(EntityDefinitions[skin])
  self.skin = skin

  Entity.init(self, {
    -- from definition
    width = EntityDefinitions[self.skin].width,
    height = EntityDefinitions[self.skin].height,
    interval = EntityDefinitions[self.skin].interval,
    speed = EntityDefinitions[self.skin].speed,

    frames = EntityDefinitions[self.skin].frames,
    texture = EntityDefinitions[self.skin].texture,

    animations = EntityDefinitions[self.skin].animations,

    -- from input
    x = x or 0,
    y = y or 0,
  })

  self.stateMachine = StateMachine {
    ['idle'] = function () return EntityIdleState(self) end,
    ['walk'] = function () return EntityWalkState(self) end,
  }
  self.stateMachine:change('idle')
end