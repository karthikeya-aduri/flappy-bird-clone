GameOverState = Class{__includes=BaseState}

function GameOverState:enter(params)
    self.score = params.score
end

function GameOverState:update(dt)
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

function GameOverState:render()
    love.graphics.setFont(FlappyFont)
    love.graphics.printf({{0, 0, 0}, 'GAME OVER'}, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(MediumFont)
    love.graphics.printf({{0, 0, 0}, 'Score : '..tostring(self.score)}, 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf({{0, 0, 0}, 'Press Enter to play again, Esc to quit the game'}, 0, 140, VIRTUAL_WIDTH, 'center')
end
