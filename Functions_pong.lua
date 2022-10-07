--here is where I put the functions, I do it mostly to practice arguments and keeping the main clean
push = require "push"


-- The variables that indicate the space where the game is going to happen
WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 600

-- Virtual resolution sizes
VIRTUAL_WIDTH = 423
VIRTUAL_HEIGHT = 243

-- Standard paddle movement constant
PADDLE_SPEED = 200


function love.load()
    -- Using this function I initialize the game, it is excecuted at the beggining
    -- This is another function for the setup, I used setMode, but this one appears to be better
    -- This function prevents the text to be blurry and also to set it a little more 8bit like
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- This is the font for the score
    score_Font = love.graphics.newFont('font.ttf', 32)

    -- This is the font is use for the intro text
    hello_pong = love.graphics.newFont('font.ttf', 8)

    -- This code sets the screen that we are going to use
    push: setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Setting the player scores
    playerScore1 = 0
    playerScore2 = 0

    -- Setting the positioning of the paddles
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

end


function love.update(dt)
    -- Movement of the Player1
    if love.keyboard.isDown("w") then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown("s") then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- Movement of the Player2
    if love.keyboard.isDown("up") then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown("down") then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    
    -- Cleaning everything to print it again in the preset order
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    -- Setting the font I use to put the intro font
    love.graphics.setFont(hello_pong)

    -- This one lets me print, is incredible to look for the values of the variables.
    -- Still dont know a lot about it, but for now it works for me
    -- Before I used the Window sizes but now Im using the Virtual ones after using the push library
    love.graphics.printf(
        "Hello Pong",
        0,
        VIRTUAL_HEIGHT / 5, -- I changed the distance so the text doesnt collide with the ball
        VIRTUAL_WIDTH,
        "center"
    )

    -- Using the font size I use to put the score and the print of the scores and next the player scores
    love.graphics.setFont(score_Font)

    love.graphics.print(
        tostring(playerScore1),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3 - 25
        
    )

    love.graphics.print(
        tostring(playerScore1),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3 - 25
        
    )

    -- Paddle 1 location 
    love.graphics.rectangle("fill", 10, player1Y, 5, 20)

    -- Paddle 2 location 
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    

    -- And this is the ball
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)


    -- Stop using the virtual resolution
    push:apply("end")
end

