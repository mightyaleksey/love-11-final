StateStack = Class{}

function StateStack:init()
  self.states = {}
end

function StateStack:render()
  for i, state in ipairs(self.states) do
    state:render()
  end
end

function StateStack:update(dt)
  -- update the only top state in the stack
  self.states[#self.states]:update(dt)
end

-- [[ helpers ]]

function StateStack:clear()
  self.states = {}
end

function StateStack:pop()
  self.states[#self.states]:exit()
  table.remove(self.states)
end

function StateStack:push(state)
  table.insert(self.states, state)
  state:enter()
end