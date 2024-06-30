Tile = Class{}

-- make it as a static method
function Tile.render(index, x, y, mapID, leftMapID, rightMapID, topMapID, bottomMapID)
  local frameID = 0

  -- map id to particular frame
  if mapID == TILE_ROAD then
    if leftMapID == TILE_PAVEMENT then
      frameID = 795
    elseif rightMapID == TILE_PAVEMENT then
      frameID = 794
    else
      frameID = index % 2 == 0 and 786 or 787
    end
  elseif mapID == TILE_PARKING then
    if topMapID == TILE_PAVEMENT then
      frameID = 904
    elseif bottomMapID == TILE_PAVEMENT then
      frameID = 867
    elseif rightMapID == TILE_PAVEMENT then
      frameID = 868
    else
      frameID = 714
    end
  elseif mapID == TILE_PAVEMENT then
    if leftMapID == TILE_ROAD then
      frameID = 746
    elseif rightMapID == TILE_ROAD then
      frameID = 748
    else
      frameID = 747
    end
  end

  love.graphics.draw(
    gTextures['modernCity'],
    gFrames['modernCity'][frameID + 1],
    x,
    y
  )
end