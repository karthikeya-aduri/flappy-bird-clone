Push = require('push')

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird Clone')
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        borderless = false
    })
end

function love.resize(w, h)
    Push:resize(w,h)
end

function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED*dt) % VIRTUAL_WIDTH
end

function love.draw()
    Push:start()
    love.graphics.draw(background, 0-backgroundScroll, 0)
    love.graphics.draw(ground, 0-groundScroll, VIRTUAL_HEIGHT-16)
    Push:finish()
end
