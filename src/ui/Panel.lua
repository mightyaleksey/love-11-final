Panel = Class{}

function Panel:init(opt)
  -- dimensions
  self.width = opt.width
  self.height = opt.height
  self.x = opt.x
  self.y = opt.y

  self.isVisibleState = true
end

function Panel:render()
  if self.isVisibleState then
    -- background
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.rectangle(
      'fill',
      self.x + 1,
      self.y + 1,
      self.width - 2,
      self.height - 2,
      6
    )

    -- borders
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle(
      'line',
      self.x + 1,
      self.y + 1,
      self.width - 2,
      self.height - 2,
      5
    )
    love.graphics.rectangle(
      'line',
      self.x + 4,
      self.y + 4,
      self.width - 8,
      self.height - 8,
      3
    )
  end
end

-- [[ helpers ]]

function Panel:togger()
  self.isVisibleState = not self.isVisibleState
end