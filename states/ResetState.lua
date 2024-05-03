ResetState = Class{__includes=BaseState}

function ResetState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        Scrolling = true
        GstateMachine:change('countdown',{
            bird = Bird(),
            pipePairs = {},
            timer = 0,
            score = 0,
            state = 0,
            lastY = -PIPE_HEIGHT + math.random(80) + 20
        })
    end
end

function ResetState:render()
    love.graphics.setFont(FlappyFont)
    love.graphics.printf({{0, 0, 0}, 'Game has been reset.'}, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(MediumFont)
    love.graphics.printf({{0, 0, 0}, 'Press enter to restart'}, 0, 100, VIRTUAL_WIDTH, 'center')
end
