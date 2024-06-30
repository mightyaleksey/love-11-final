EntityDefinitions = {
  -- passangers
  ['passanger1'] = {
    width = 16,
    height = 16,
    interval = 0.2,
    speed = 10,

    frames = 'passangers',
    texture = 'urban',

    animations = {
      ['idle-left'] = {
        frames = { 1 },
      },
      ['idle-bottom'] = {
        frames = { 2 },
      },
      ['idle-top'] = {
        frames = { 3 },
      },
      ['idle-right'] = {
        frames = { 4 },
      },
      ['walk-left'] = {
        frames = { 5, 1, 9, 1 },
      },
      ['walk-bottom'] = {
        frames = { 6, 2, 10, 2 },
      },
      ['walk-top'] = {
        frames = { 7, 3, 11, 3 },
      },
      ['walk-right'] = {
        frames = { 8, 4, 12, 4 },
      },
    }
  },
  ['passanger2'] = {
    width = 16,
    height = 16,
    interval = 0.2,
    speed = 10,

    frames = 'passangers',
    texture = 'urban',

    animations = {
      ['idle-left'] = {
        frames = { 13 },
      },
      ['idle-bottom'] = {
        frames = { 14 },
      },
      ['idle-top'] = {
        frames = { 15 },
      },
      ['idle-right'] = {
        frames = { 16 },
      },
      ['walk-left'] = {
        frames = { 17, 13, 21, 13 },
      },
      ['walk-bottom'] = {
        frames = { 18, 14, 22, 14 },
      },
      ['walk-top'] = {
        frames = { 19, 15, 23, 15 },
      },
      ['walk-right'] = {
        frames = { 20, 16, 24, 16 },
      },
    }
  },

  -- vehicles
  ['vehicleGreen'] = {
    width = 20,
    height = 30,
    interval = 1,

    frames = 'vehicle',
    texture = 'modernCity',

    animations = {
      ['drive-bottom'] = {
        frames = { 2 },
      },
      ['drive-top'] = {
        frames = { 1 },
      },
    },
  },
  ['vehicleGray'] = {
    width = 20,
    height = 30,
    interval = 1,

    frames = 'vehicle',
    texture = 'modernCity',

    animations = {
      ['drive-bottom'] = {
        frames = { 4 },
      },
      ['drive-top'] = {
        frames = { 3 },
      },
    },
  },
  ['vehicleOrange'] = {
    width = 20,
    height = 30,
    interval = 1,

    frames = 'vehicle',
    texture = 'modernCity',

    animations = {
      ['drive-bottom'] = {
        frames = { 6 },
      },
      ['drive-top'] = {
        frames = { 5 },
      },
    },
  },
}