Animation = Class{}

function Animation:init(opt)
  defineProperties(self, opt, { 'frames', 'interval' })

  self.currentFrame = 1
  self.timer = 0
  self.timesPlayed = 0

  self.looping = opt.looping or true
end

function Animation:update(dt)
  -- single frame available, quit early
  if #self.frames < 2 then
    return
  end

  -- one cycle behind, quit if not looping
  if
    not self.looping and
    self.timesPlayed > 0
  then
    return
  end

  self.timer = self.timer + dt

  if self.timer > self.interval then
    -- end of cycle, increase counter
    if self.currentFrame == #self.frames then
      self.timesPlayed = self.timesPlayed + 1

      -- quit if not looping
      if not self.looping then
        return
      end
    end

    -- switch frame
    self.timer = self.timer % self.interval
    self.currentFrame = self.currentFrame % #self.frames + 1
  end
end

-- [[ helpers ]]

function Animation:getCurrentFrame()
  return self.frames[self.currentFrame]
end

function Animation:refresh()
  self.currentFrame = 1
  self.timer = 0
  self.timesPlayed = 0
end