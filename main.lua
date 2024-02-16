Push = require('push')
Class = require('class')
require('classes.Bird')
require('classes.Pipe')
require('classes.PipePair')

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514

local bird = Bird()

local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

local timerReset = 2

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird Clone')
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    Push:resize(w,h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key=='escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED*dt) % GROUND_LOOPING_POINT

        spawnTimer = spawnTimer + dt

        if spawnTimer>timerReset then
            timerReset = math.random(2, 3)
            local y = math.max(-PIPE_HEIGHT+10, math.min(lastY+math.random(-20, 20), VIRTUAL_HEIGHT-90-PIPE_HEIGHT))
            lastY = y;
            table.insert(pipePairs, PipePair(y))
            spawnTimer = 0
        end

        bird:update(dt)

        for k, pair in pairs(pipePairs) do
            pair:update(dt)
            for l, pipe in pairs(pair.pipes) do
                if bird:collides(pipe) then
                    scrolling = false
                end
            end

            if pair.x < -PIPE_WIDTH then
                pair.remove()
            end
        end

        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end

        if (bird.y > (VIRTUAL_HEIGHT-16-bird.height) or bird.y<0) then
            scrolling = false
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)
    bird:render()
    Push:finish()
end
