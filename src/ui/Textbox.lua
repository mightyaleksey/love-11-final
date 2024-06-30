Textbox = Class{}

function Textbox:init(opt)
  -- dimensions
  self.width = opt.width
  self.height = opt.height
  self.x = opt.x
  self.y = opt.y

  -- text attributes
  assert(opt.text)
  self.font = opt.font and gFonts[opt.font] or gFonts['medium']
  self.text = opt.text

  -- container
  self.panel = Panel {
    width = self.width,
    height = self.height,
    x = self.x,
    y = self.y,
  }

  -- pages
  self.currentLine = 1
  self.eof = false
  self.lineHeight = self.font:getHeight() + 2
  self.maxLines = math.floor((self.height - 16) / self.lineHeight)
  w, self.lines = self.font:getWrap(self.text, self.width - 16)
  -- lines in the current page
  self.page = nil

  -- internal states
  self.isClosedState = false

  self:nextPage()
end

function Textbox:render()
  self.panel:render()

  love.graphics.setColor(0.1, 0.1, 0.1, 1)
  love.graphics.setFont(self.font)

  for i = 1, #self.page do
    love.graphics.print(
      self.page[i],
      self.x + INNER_OFFSET,
      self.y + INNER_OFFSET + self.lineHeight * (i - 1)
    )
  end
end

function Textbox:update(dt)
  if Keys.wasPressed('escape') then
    self.isClosedState = true
  end

  if Keys.wasPressed('return') then
    self:nextPage()
  end
end

-- [[ helpers ]]

function Textbox:nextPage()
  if self.eof then
    self.isClosedState = true
    return
  end

  self.page = {}

  for i = self.currentLine, self.currentLine + self.maxLines - 1 do
    table.insert(self.page, self.lines[i])

    if i == #self.lines then
      self.eof = true
      return
    end
  end

  self.currentLine = self.currentLine + self.maxLines
end