Push = require('push')

Class = require('class')
require('classes.Bird')
require('classes.Pipe')
require('classes.PipePair')

require('classes.StateMachine')
require('states.BaseState')
require('states.TitleScreenState')
require('states.CountdownState')
require('states.PlayState')
require('states.PauseState')
require('states.ResetState')
require('states.GameOverState')

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

Scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy Bird Clone')

    SmallFont = love.graphics.newFont('fonts/base.ttf', 8)
    MediumFont = love.graphics.newFont('fonts/flap.ttf', 14)
    FlappyFont = love.graphics.newFont('fonts/flap.ttf', 28)
    love.graphics.setFont(FlappyFont)

    Sounds = {
        ['jump'] = love.audio.newSource('assets/sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('assets/sounds/explosion.wav', 'static'),
        ['score'] = love.audio.newSource('assets/sounds/score.wav', 'static'),
        ['hit'] = love.audio.newSource('assets/sounds/hit.wav', 'static'),

        --https://freesound.org/people/neolein/sounds/417974/
        ['music'] = love.audio.newSource('assets/sounds/spring-theme.wav', 'static')
    }

    Sounds['music']:setLooping(true)
    Sounds['music']:play()

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    GstateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['reset'] = function() return ResetState() end,
        ['over'] = function() return GameOverState() end,
    }
    GstateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    Push:resize(w, h)
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
    if Scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT
    end
    GstateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    GstateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)
    Push:finish()
end
