function genQuads(atlas, tileWidth, tileHeight, left, top, right, bottom)
  local atlasWidth = (right or atlas:getWidth()) - tileWidth
  local atlasHeight = (bottom or atlas:getHeight()) - tileHeight
  local spritesheet = {}
  local sheetCounter = 0

  for y = top or 0, atlasHeight, tileHeight do
    for x = left or 0, atlasWidth, tileWidth do
      sheetCounter = sheetCounter + 1
      spritesheet[sheetCounter] =
        love.graphics.newQuad(
          x, y, tileWidth, tileHeight, atlas:getDimensions()
        )
    end
  end

  return spritesheet
end

function genVehicleQuads(atlas)
  local spritesheet = {}
  local coords = {
    { 496, 288, 64, 32 },
    { 496, 352, 64, 32 },
    { 496, 416, 64, 32 },
  }

  for _, c in ipairs(coords) do
    for x = c[1], c[1] + c[3] - 1, 32 do
      table.insert(
        spritesheet,
        love.graphics.newQuad(
          x, c[2], 32, 32, atlas:getDimensions()
        )
      )
    end
  end

  return spritesheet
end