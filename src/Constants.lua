-- physical screen dimensions / 0.5625, 16x9
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- colors
COLORS = {
  ['black'] = { r = 0.1, g = 0.1, b = 0.1 },
  ['blue'] = { r = 52/255, g = 126/255, b = 221/255 },
  ['green'] = { r = 25/255, g = 169/255, b = 116/255 },
  ['light-green'] = { r = 158/255, g = 235/255, b = 207/255 },
  ['red'] = { r = 255/255, g = 65/255, b = 54/255},
  ['white'] = { r = 1, g = 1, b = 1 },
}
INNER_OFFSET = 12
-- entities
PASSANGER_SKINS = { 'passanger1', 'passanger2' }
VEHICLE_SKINS = { 'vehicleGreen', 'vehicleGray', 'vehicleOrange' }
-- game
PASSANGER_MESSAGES = {
  'Hey, taxi! \nI\'m in a rush and need to get to airport asap!',
  'Hey! \nI\'m running late for my date, please help!',
}

-- tiles
TILE_SIZE = 16
TILE_ROAD = 6
TILE_PARKING = 7
TILE_PAVEMENT = 1
-- map
PARKING_POINT = { 6, 9 }

-- timings
PLAYER_SPEED = 100
VEHICLE_SPEED = 60
TAKE_TURN_DELAY = 0.1
TAKE_TURN_INTERVAL = 0.1