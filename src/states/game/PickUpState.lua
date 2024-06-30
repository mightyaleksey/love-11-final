PickUpState = Class{__includes = BaseState}

function PickUpState:init(playState)
  self.playState = playState

  self.passanger = Passanger(
    PASSANGER_SKINS[math.random(#PASSANGER_SKINS)],
    self.playState.map:getStartX() + TILE_SIZE,
    self.playState.map:getStartY() + 0.5 * TILE_SIZE
  )
  self.passanger.direction = 'left'
  self.passanger:changeState('idle')
end

function PickUpState:enter()
  -- generate passing by car while picking up a passenger
  self.playState.map:genVehicle('bottom', VEHICLE_SKINS[1])

  -- make sure time is greater then transition duration,
  -- otherwise state order in the stack will be messed up
  Timer.after(0.6, function ()
    local message = PASSANGER_MESSAGES[math.random(#PASSANGER_MESSAGES)]

    gStateStack:push(DialogueState {
      text = message..' \n(Press Enter to start)',
      onComplete = function ()
        gSounds['confirm']:play()
        self.passanger:changeState('walk')

        Timer.after(1, function ()
          self.passanger:changeState('idle')

          Timer.after(0.2, function ()
            gSounds['door']:play()
            self.playState.player:changeState('turnLeft')
            gStateStack:pop()
          end)
        end)
      end,
    })
  end)
end

function PickUpState:render()
  self.passanger:render()
end

function PickUpState:update(dt)
  self.playState.map:update(dt)
  self.passanger:update(dt)
end