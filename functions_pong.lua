--here is where I put the functions, I do it mostly to practice arguments and keeping the main clean
push = require ("push")
Class = require ("class")
require ('Paddle')
require ('Ball')

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
    
    love.window.setTitle("Pong")
    math.randomseed(os.time())

    -- This is the font for the score, and the one for the intro
    score_Font = love.graphics.newFont('font.ttf', 32)
    hello_pong = love.graphics.newFont('font.ttf', 8)

    -- This code sets the screen that we are going to use
    push: setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Setting the player scores HACER ATRIBUTO DE PLAYER
    playerScore1 = 0
    playerScore2 = 0

    -- Creating the objects
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - -2, 4, 4)
    
    servingPlayer = math.random(1, 2)
    
    --Initializing the state of the game
    gameState = "start"
end


function love.update(dt)

    if gameState == "serve" then
        ball.dy = math.random(-50, 50)

        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else 
            ball.dx = -math.random(140, 200)
        end
    end

    -- AABB collision detection
    if gameState == "play" then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end
    end

    if ball.x < 0 then
        servingPlayer = 1
        playerScore2 = playerScore2 + 1
        gameState = "serve"
        ball:reset()
    end

    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        playerScore1 = playerScore1 + 1
        gameState = "serve"
        ball:reset()
    end
        

     -- Movement of the Player1
     if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- Movement of the Player2
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- Movement of the Ball
    if gameState == "play" then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end


function love.keypressed(key)
    -- Escape key for leaving the game
    if key == "escape" then
        love.event.quit()

    -- Key to start the game and reset it
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        end
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
    if gameState == "start" then
        love.graphics.printf("Hello Start State!", 0, 20, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press enter to start!", 0, 30, VIRTUAL_WIDTH, "center")
    end

    if gameState == "serve" then
        love.graphics.printf("Player" .. tostring(servingPlayer) .. "'s serve!", 0, 20, VIRTUAL_WIDTH, "center")
    end
    -- Using the font size I use to put the score and the print of the scores and next the player scores
    love.graphics.setFont(score_Font)

    love.graphics.print(
        tostring(playerScore1),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3 - 25
    )

    love.graphics.print(
        tostring(playerScore2),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3 - 25
        
    )
    -- Put the paddles and the ball
    player1:render()
    player2:render()
    ball:render()

    love.graphics.setFont(hello_pong)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print("FPS: ".. tostring(love.timer.getFPS()), 10, 10)
    -- Stop using the virtual resolution
    push:apply("end")
end

--Functions for factorize code

