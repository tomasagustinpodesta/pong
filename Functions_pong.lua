--here is where I put the functions, I do it mostly to practice arguments and keeping the main clean
push = require "push"
-- The variables that indicate the space where the game is going to happen
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Virtual resolution sizes
VIRTUAL_WIDTH = 423
VIRTUAL_HEIGHT = 243

function love.load()
    -- Using this function I initialize the game, it is excecuted at the beggining
    -- This is another function for the setup, I used setMode, but this one appears to be better
    
    -- This function prevents the text to be blurry and also to set it a little more 8bit like
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- This code sets the screen that we are going to use
    push: setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    end

function love.keypressed(key)
    -- Escape key for leaving the game
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    -- Now we are using the virtual resolution with push:apply
    push:apply("start")

    -- This one lets me print, is incredible to look for the values of the variables.
    -- Still dont know a lot about it, but for now it works for me
    -- Before I used the Window sizes but now Im using the Virtual ones after using the push library
    love.graphics.printf(
        "Hello Pong",
        0,
        VIRTUAL_HEIGHT / 2 - 6,
        VIRTUAL_WIDTH,
        "center"
    )
    -- Stop using the virtual resolution
    push:apply("end")
end

