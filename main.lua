--functions and push
func = require("Functions_pong")
push = require("push")

-- Space where we play the game, i didnt find anything of use if I use the functions file
--mainly because I cant pass parameters from main for the moment
-- I might take it out if I dont see anything of use, but for now I keep it 
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Creating the space for the game
love.load()
-- Hello world
love.draw()
