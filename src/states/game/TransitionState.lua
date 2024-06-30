TransitionState = Class{__includes = BaseState}

function TransitionState:init(opt)
  assert(opt.animation == 'fadeIn' or opt.animation == 'fadeOut')
  self.animation = opt.animation
  self.color = opt.color or 'white'
  self.duration = opt.duration or 0.3
  self.onComplete = opt.onComplete or emptyFunction
  self.opacity = self:getInitialOpacity()

  Timer.tween(self.duration, {
    [self] = { opacity = self:getTargetOpacity() }
  })
  :ease(self:getEasingFn())
  :finish(function ()
    -- remove self from stack
    gStateStack:pop()
    self.onComplete()
  end)
end

function TransitionState:render()
  setColor(self.color, self.opacity)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

-- [[ helpers ]]

function TransitionState:getEasingFn()
  return self.animation == 'fadeIn'
    and easingFunctions.inCubic
    or easingFunctions.outCubic
end

function TransitionState:getInitialOpacity()
  return self.animation == 'fadeIn' and 0 or 1
end

function TransitionState:getTargetOpacity()
  return self.animation == 'fadeIn' and 1 or 0
end