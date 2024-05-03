PauseState = Class{__includes=BaseState}

function PauseState:enter(params)
    self.params = params
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        GstateMachine:change('countdown',self.params)
    end
end

function PauseState:render()
    self.params.bird:render()

    for k, pair in pairs(self.params.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(FlappyFont)
    love.graphics.printf({{0, 0, 0}, 'PAUSED.'}, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(MediumFont)
    love.graphics.printf({{0, 0, 0}, 'Press enter to resume'}, 0, 100, VIRTUAL_WIDTH, 'center')
end
