PlayState = Class{__includes=BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:enter(params)
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.score = params.score
    self.resetTime = 2
    self.lastY = params.lastY
end

function PlayState:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.resetTime then
        self.resetTime = math.random(2, 3)
        local y = math.max(-PIPE_HEIGHT+10, math.min(self.lastY+math.random(-20,20), VIRTUAL_HEIGHT-90-PIPE_HEIGHT))
        self.lastY = y
        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x+PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                Sounds['score']:play()
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                GstateMachine:change('over', {score = self.score})
                Sounds['explosion']:play()
                Sounds['hit']:play()
                Scrolling = false
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT-15 or self.bird.y < -BIRD_HEIGHT then
        GstateMachine:change('over', {score = self.score})
        Sounds['explosion']:play()
        Sounds['hit']:play()
        Scrolling = false
    end

    if love.keyboard.wasPressed('r') then
        Scrolling = false
        GstateMachine:change('reset')
    end

    if love.keyboard.wasPressed('p') then
        Scrolling = false
        GstateMachine:change('pause',{
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(FlappyFont)
    love.graphics.print({{0, 0, 0}, tostring(self.score)}, 8, 8)

    self.bird:render()
end
