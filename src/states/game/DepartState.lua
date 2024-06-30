DepartState = Class{__includes = BaseState}

function DepartState:init(playState)
  self.playState = playState
  self.player = self.playState.player

  self.hasArrived = false
end

function DepartState:enter()
  Timer.tween(0.6, {
    [self.player] = {
      x = self.playState.map.rightRoadX - 0.5 * TILE_SIZE
    }
  })
  :finish(function ()
    self.hasArrived = true

    Timer.after(0.5, function ()
      gStateStack:push(DialogueState {
        text = 'Just in time! Thank you!',
        onComplete = function ()
          gStateStack:push(TransitionState {
            animation = 'fadeIn',
            onComplete = function ()
              local level = self.playState.map.level

              -- remove self
              gStateStack:pop()
              -- remove play state
              gStateStack:pop()
              gStateStack:push(GameEndState(true, level))
              gStateStack:push(TransitionState {
                animation = 'fadeOut'
              })
            end,
          })
        end,
      })
    end)
  end)
end

function DepartState:update(dt)
  self.playState.map:update(dt)

  if not self.hasArrived then
    self.player:update(dt)
  end
end