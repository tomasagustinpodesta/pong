--here is where I put the functions, I do it mostly to practice arguments and keeping the main clean


function love.load()
    -- Using this function I prepare the setup for the game
    -- I really want to pass parameters in here but it seems that I cant, 
    --parameter variables are tretated as tables aparently
    love.window.setMode(
        1280, 720,{
        fullscreen = false,
        resizable = false,
        vsync = true
        }) 
    end

function love.draw()
    -- This one lets me print, is incredible to look for the values of the variables.
    -- Still dont know a lot about it, but for now it works for me
    love.graphics.printf(
        "Hello Pong",
        0,
        310,
        1280,
        "center"
    )
end

