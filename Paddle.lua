lass = require "class"

Paddle = Class{}

-- Creating the instance of the paddle
function Paddle:init(x, y, width, height)
    -- position
    self.x = x
    self.y = y

    -- size
    self.width = width
    self.height = height
end

-- Printing the paddle in the screen
function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Collision of the paddles
function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end
