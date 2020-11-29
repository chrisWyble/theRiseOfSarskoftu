local projectile = require('projectile')
local player = {tag='player'}

local running_frames = {
        frames = {
            { x = 0, y = 0, width = 16, height = 32}, --frame 1
            { x = 16, y = 0, width = 16, height = 32}, --frame 2
            { x = 32, y = 0, width = 16, height = 32}, --frame 3
            { x = 48, y = 0, width = 16, height = 32}, --frame 4
            { x = 113, y =0, width = 16, height = 32}, --frame 5
            { x = 129, y = 0, width=16, height =32}, --frame 6
            { x = 96, y =10, width=16, height=22}
        }
    }
local running = graphics.newImageSheet("mario.png", running_frames)
local running_sequence = {
    {
        name = 'stand',
        frames = {1},
        time = 100,
        loopCount = 1
    },
    {
        name = 'running',
        frames = {2,3,4},
        time = 600,
        loopCount = 0
    },
    {
        name = 'jump',
        frames = {5,6,7},
        time = 1000,
        loopCount = 1
    }
}
-- local running_anim = display.newSprite(running, running_sequence)

function player:new (o)    --constructor
    o = o or {} 
    setmetatable(o, self)
    self.__index = self
    if o.x and o.y then
        self:spawn(o)
        self:keyboard_input(o)
    end
    return o;
end
  
function player:spawn(o)
    self = o
    self.shape = display.newSprite(running, running_sequence);
    self.shape:setSequence('stand')
    self.shape.x = self.x
    self.shape.y = self.y
    self.shape.dir = 1 -- 1 = right ; -1 = left
    self.shape.pp = self  -- parent
    self.shape.tag = self.tag 
    physics.addBody(self.shape, 'dynamic', {friction=0.0, bounce=0})
    self.shape.isFixedRotation = true

    local function onGround(self, event)
        if event.phase == 'began' then 
            self.jumptoggle = true
            
        end
    end

    self.shape.collision = onGround
    self.shape:addEventListener('collision')
end

function player:moveRight(phase)
    if phase == 'down' then 
        if self.shape.dir == -1 then 
            self.shape:scale(-1,1)
            self.shape.dir = 1
        end
        self.shape:setSequence('running')
        self.shape:play()
        self.shape:setLinearVelocity(50, currentYV)
    else 
        self.shape:setLinearVelocity(0,currentYV)
        self.shape:setSequence('stand')
    end
end

function player:moveLeft(phase)
    if phase == 'down' then
        if self.shape.dir == 1 then 
            self.shape:scale(-1,1)
            self.shape.dir = -1
        end
        self.shape:setSequence('running')
        self.shape:play()
        self.shape:setLinearVelocity(-50, currentYV)
    else
        self.shape:setLinearVelocity(0,currentYV)
        self.shape:setSequence('stand')
    end
end

function player:jump()
    if self.shape.jumptoggle then
        self.shape.jumptoggle = false
        self.shape:setSequence('jump')
        self.shape:play()
        self.shape:setLinearVelocity(currentXV, -200)
    end
end

function player:shoot()
    bullet = projectile:new({x=self.shape.x, y=self.shape.y, dir=self.shape.dir})
end

function player:keyboard_input(o)
    self = o

    local function keyboard(event)
        currentXV, currentYV = self.shape:getLinearVelocity()
        if event.keyName == "w" and event.phase == 'down' then
            self:jump()
        end
        if event.keyName == "d" then
            self:moveRight(event.phase)
        end
        if event.keyName == "a"  then
            self:moveLeft(event.phase)
        end
        if event.keyName == "space" and event.phase == 'down' then
            self:shoot()
        end
    end

    Runtime:addEventListener("key", keyboard)
end


return player
