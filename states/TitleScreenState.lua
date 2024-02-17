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
    love.graphics.printf({{0, 0, 0}, 'Press Enter to play'}, 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf({{0, 0, 0}, 'Contols: Esc=Exit, Space=Jump,'}, 0, 160, VIRTUAL_WIDTH, 'center')
    love.graphics.printf({{0, 0, 0}, '         r=Restart, p=Pause.'}, 0, 186, VIRTUAL_WIDTH, 'center')
end
