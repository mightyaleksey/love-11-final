GameEndState = Class{__includes = BaseState}

function GameEndState:init(isVictory, level)
  self.level = level or 1
  self.isVictory = isVictory == true

  self.bg = self.isVictory and 'bgSuccess' or 'bgFail'
end

function GameEndState:enter()
  gSounds['victory']:play()
end

function GameEndState:render()
  love.graphics.setColor(1, 1, 1, 1)
  renderBg(self.bg, 1.1)
  renderOverlay()

  if self.isVictory then
    renderTitle('Good Job!')
    renderBody('Press Enter to pick another passenger')
  else
    renderTitle('Too Fast!')
    renderBody('Fortunately, no one was hurt!')
  end
end

function GameEndState:update(dt)
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('return') then
    gStateStack:push(TransitionState {
      animation = 'fadeIn',
      onComplete = function ()
        -- remove self
        gStateStack:pop()
        gStateStack:push(GamePlayState(self.level + 1))
        gStateStack:push(TransitionState {
          animation = 'fadeOut'
        })
      end,
    })
  end
end