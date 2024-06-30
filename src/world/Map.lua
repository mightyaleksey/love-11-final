Map = Class{}

function Map:init(level)
  -- viewport size: 32x18
  self.level = level or 1
  self.viewportWidth = math.floor(VIRTUAL_WIDTH / TILE_SIZE)
  self.viewportHeight = math.floor(VIRTUAL_HEIGHT / TILE_SIZE)

  -- total distance
  self.distance = 90 + 36 * self.level
  -- number of lanes where player can move
  self.lanes = 4

  -- camera position
  self.scrollY = 0
  self.entities = {}
  self.tiles = {}
  self:genTiles()

  self.offsetX = 0.5 * (self.viewportWidth - #self.tiles[1]) * TILE_SIZE
  -- helpers to check if player still on the road
  self.leftRoadX = self.offsetX + 2 * TILE_SIZE
  self.rightRoadX = self.leftRoadX + 2 * self.lanes * TILE_SIZE
end

function Map:render()
  local startY = math.max(1, -math.floor(self.scrollY / TILE_SIZE))

  -- render road
  for y = startY, startY + self.viewportHeight + 1 do
    local counter = 1
    local lastMapID = nil

    for x = 1, #self.tiles[y] do
      local mapID = self:getTile(x, y)

      if mapID ~= lastMapID then
        counter = 1
        lastMapID = mapID
      else
        counter = counter + 1
      end

      Tile.render(
        counter,
        (x - 1) * TILE_SIZE + self.offsetX,
        VIRTUAL_HEIGHT + TILE_SIZE - y * TILE_SIZE,
        mapID,
        self:getTile(x - 1, y),
        self:getTile(x + 1, y),
        self:getTile(x, y - 1),
        self:getTile(x, y + 1)
      )
    end
  end

  -- render entities
  for k, entity in ipairs(self.entities) do
    entity:render()
  end
end

function Map:update(dt)
  -- update entities position and clean up if needed
  for k = #self.entities, 1, -1 do
    local entity = self.entities[k]
    entity:update(dt)

    if entity.y - self.scrollY > VIRTUAL_HEIGHT then
      table.remove(self.entities, k)
    end
  end
end

-- [[ helpers ]]

function Map:genTiles()
  local width = 4 + 2 * self.lanes
  local deltaY = PARKING_POINT[2] - PARKING_POINT[1]
  local destinationY = self:getTargetY()

  for y = 1, self.distance do
    table.insert(self.tiles, {})

    for x = 1, width do
      local mapID = TILE_PAVEMENT

      if
        y >= PARKING_POINT[1] and y <= PARKING_POINT[2] or
        y >= destinationY and y <= destinationY + deltaY
      then
        if x == width - 2 or x == width - 1 then
          mapID = TILE_PARKING
        elseif x > 2 and x < width - 2 then
          mapID = TILE_ROAD
        end
      else
        if x > 2 and x < width - 1 then
          mapID = TILE_ROAD
        end
      end

      table.insert(self.tiles[y], mapID)
    end
  end
end

function Map:genTraffic()
  if self:getRemainingDistance() < 6 then
    return
  end

  local startY = self:getTopOffsetForVehicle()
  local hasBottomVehicle = false
  local hasTopVehicle = false

  for _, entity in ipairs(self.entities) do
    if
      entity.direction == 'top' and
      math.abs(entity.y - startY) < 6 * TILE_SIZE
    then
      hasTopVehicle = true
    end

    if
      entity.direction == 'bottom' and
      math.abs(entity.y - startY) < 8 * TILE_SIZE
    then
      hasBottomVehicle = true
    end
  end

  if not hasTopVehicle then
    self:genVehicle('top')
  end

  if not hasBottomVehicle then
    self:genVehicle('bottom')
  end
end

function Map:genVehicle(direction, skin)
  assert(direction == 'top' or direction == 'bottom')

  local lane = direction == 'top'
    and math.random(0.5 * self.lanes + 1, self.lanes)
    or math.random(1, 0.5 * self.lanes)

  local vehicle = Vehicle(
    skin or VEHICLE_SKINS[math.random(#VEHICLE_SKINS)],
    self:getLeftOffsetForLane(lane),
    self:getTopOffsetForVehicle()
  )
  vehicle:changeDirection(direction)

  table.insert(self.entities, vehicle)
end

function Map:getLeftOffsetForLane(num)
  return self.offsetX + 2 * num * TILE_SIZE
end

function Map:getTopOffsetForVehicle()
  return self.scrollY - 2 * TILE_SIZE
end

function Map:getStartX()
  return self.offsetX + (2 * self.lanes + 2) * TILE_SIZE
end

function Map:getStartY()
  return VIRTUAL_HEIGHT - PARKING_POINT[1] * TILE_SIZE
end

function Map:getRemainingDistance()
  return self:getTargetY() + math.floor(self.scrollY / TILE_SIZE) - 6
end

function Map:getTargetY()
  return self.distance - self.viewportHeight
end

function Map:getTile(x, y)
  if x < 1 or x > #self.tiles[1] then
    return nil
  end

  if y < 1 or y > #self.tiles then
    return nil
  end

  return self.tiles[y][x]
end
