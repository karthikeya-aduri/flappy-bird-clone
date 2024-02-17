ResetState = Class{__includes=BaseState}

function ResetState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        Scrolling = true
        GstateMachine:change('countdown')
    end
end

function ResetState:render()
    love.graphics.setFont(FlappyFont)
    love.graphics.printf({{0, 0, 0}, 'Game has been reset.'}, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(MediumFont)
    love.graphics.printf({{0, 0, 0}, 'Press enter to start again'}, 0, 100, VIRTUAL_WIDTH, 'center')
end
