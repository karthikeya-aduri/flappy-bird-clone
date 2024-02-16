PlayState = Class{__includes=BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.resetTime = 2
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
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
                GstateMachine:change('title')
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT-15 or self.bird.y < -BIRD_WIDTH then
        GstateMachine:change('title')
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    self.bird:render()
end
