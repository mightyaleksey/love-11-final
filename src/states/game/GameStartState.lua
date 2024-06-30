GameStartState = Class{__includes = BaseState}

function GameStartState:render()
  love.graphics.setColor(1, 1, 1, 1)
  renderBg('bgStart', 1.2)
  renderOverlay()
  renderTitle('Taxi Driver')
  renderBody('Press Enter')
end

function GameStartState:update()
  if Keys.wasPressed('escape') then
    love.event.quit()
  end

  if Keys.wasPressed('return') then
    gStateStack:push(TransitionState {
      animation = 'fadeIn',
      onComplete = function ()
        gStateStack:pop()
        gStateStack:push(GamePlayState())
        gStateStack:push(TransitionState {
          animation = 'fadeOut'
        })
      end,
    })
  end
end