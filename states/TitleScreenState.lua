TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        GstateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(FlappyFont)
    love.graphics.printf({{0, 0, 0}, 'Flappy Bird Clone'}, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(MediumFont)
    love.graphics.printf({{0, 0, 0}, 'Press Enter to play, Esc to exit at any point'}, 0, 100, VIRTUAL_WIDTH, 'center')
end
