EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
  assert(entity)
  self.entity = entity
  self.entity:changeAnimation('idle-'..self.entity.direction)
end