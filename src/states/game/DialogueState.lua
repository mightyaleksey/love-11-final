DialogueState = Class{__includes = BaseState}

function DialogueState:init(opt)
  self.onComplete = opt.onComplete or emptyFunction
  self.textbox = Textbox {
    width = VIRTUAL_WIDTH - 4,
    height = 0.26 * VIRTUAL_HEIGHT,
    x = 2,
    y = 2,

    text = opt.text,
  }
end

function DialogueState:render()
  self.textbox:render()
end

function DialogueState:update(dt)
  self.textbox:update(dt)

  if self.textbox.isClosedState then
    gStateStack:pop()
    self.onComplete()
  end
end