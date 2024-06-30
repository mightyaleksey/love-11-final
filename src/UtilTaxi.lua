function renderBg(textureName, multiplier)
  local texture = gTextures[textureName]
  local scaleY = VIRTUAL_HEIGHT / texture:getHeight()

  -- apply scale if needed
  scaleY = scaleY * (multiplier or 1)

  local offsetX = 0.5 * (VIRTUAL_WIDTH - texture:getWidth() * scaleY)

  love.graphics.draw(
    texture,
    offsetX, 0, 0,
    scaleY, scaleY
  )
end

function renderTitle(text)
  local offsetY = -24

  love.graphics.setFont(gFonts['title'])
  -- render shadow
  love.graphics.setColor(0, 0, 0, 0.8)
  love.graphics.printf(
    text,
    -3,
    0.5 * VIRTUAL_HEIGHT + offsetY + 4,
    VIRTUAL_WIDTH,
    'center'
  )
  -- render title
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf(
    text,
    0,
    0.5 * VIRTUAL_HEIGHT + offsetY,
    VIRTUAL_WIDTH,
    'center'
  )
end

function renderBody(text)
  local offsetY = 24

  love.graphics.setFont(gFonts['medium'])
  -- render shadow
  love.graphics.setColor(0, 0, 0, 0.8)
  love.graphics.printf(
    text,
    -1,
    0.5 * VIRTUAL_HEIGHT + offsetY + 2,
    VIRTUAL_WIDTH,
    'center'
  )
  -- render title
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf(
    text,
    0,
    0.5 * VIRTUAL_HEIGHT + offsetY,
    VIRTUAL_WIDTH,
    'center'
  )
end

function renderOverlay()
  love.graphics.setColor(0, 0, 0, 0.1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function setColor(name, opacity)
  local color = COLORS[name]

  assert(color, 'unknown color "'..tostring(name)..'"')
  love.graphics.setColor(color.r, color.g, color.b, opacity or 1)
end
