class = require "class"

Ball = Class{}

-- Create an instance of the ball
function Ball:init(x, y, width, height)
    -- position
    self.x = x
    self.y = y

    -- size
    self.width = width
    self.height = height

    --velocity
    self.dx = math.random(2) == 1 and 100 or -100 
    self.dy = math.random(-50, 50)  
end

-- Taking the ball back to its initial state
function Ball:reset()
     -- Initial position
     self.x = VIRTUAL_WIDTH / 2 - 2 
     self.y = VIRTUAL_HEIGHT / 2 - 2
     
     -- Initial velocity
     self.dx = math.random(2) == 1 and 100 or -100
     self.dy = math.random(-50, 50)
end

-- Movement of the ball
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

-- Printing the ball in the screen
function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- AABB Collision
function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    return true
end