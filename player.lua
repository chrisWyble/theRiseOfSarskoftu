local projectile = require('projectile')
local score = require('score')
local playerHealth = require('playerHealth')
local player = {tag='player'}



local running_frames = {
        frames = {
            { x = 0, y = 0, width = 16, height = 32}, --frame 1 : standing
            { x = 16, y = 0, width = 16, height = 32}, --frame 2 : run
            { x = 32, y = 0, width = 16, height = 32}, --frame 3 : run
            { x = 48, y = 0, width = 16, height = 32}, --frame 4 : run
            { x = 113, y =0, width = 16, height = 32}, --frame 5 : jump
            { x = 129, y = 0, width=16, height =32}, --frame 6 : jump
            { x = 96, y =10, width=16, height=22} -- frame 7 : jump
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

local phases = {down = true, up = false, began = true, ended = false}

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
    self.shape.dir = 1 -- 1 means player facing right ; -1 means player facing left
    self.shape.pp = self
    self.shape.tag = self.tag 
    physics.addBody(self.shape, 'dynamic', {density=10, friction=0.0, bounce=0}) --friction is 0 so that velocity is constant without needing updated, projectiles have density of 0 so they have minimal impact on player sliding
    self.shape.isFixedRotation = true

    local function collisionHandler(self, event)   -- collision detection
        if event.phase == 'began' then 
            if event.other.tag == 'platform' then  -- if landed on a platform
                self.jumptoggle = true
            
            elseif event.other.tag == 'projectile' then  -- if hit by a projectile
                -- get shot

            elseif event.other.tag == 'enemy' then  -- if hit by a enemy
                score.add(-10)
                playerHealth.add(-1)
            end 
        end
    end

    self.shape.collision = collisionHandler
    self.shape:addEventListener('collision')
end

function player:moveRight(phase)  -- phase is boolean, true means start, false means stop
    if phase then 
        if self.shape.dir == -1 then 
            self.shape:scale(-1,1)  --scale -1,1 causes flipping over y axis
            self.shape.dir = 1
        end
        self.shape:setSequence('running')
        self.shape:play()
        self.shape:setLinearVelocity(50, currentYV)
    else 
        self.shape:setLinearVelocity(0, currentYV)
        self.shape:setSequence('stand')
    end
end

function player:moveLeft(phase)  -- phase is boolean, true means start, false means stop
    if phase then
        if self.shape.dir == 1 then 
            self.shape:scale(-1,1)  --scale -1,1 causes flipping over y axis
            self.shape.dir = -1
        end
        self.shape:setSequence('running')
        self.shape:play()
        self.shape:setLinearVelocity(-50, currentYV)
    else
        self.shape:setLinearVelocity(0, currentYV)
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
    bullet = projectile:new({x=self.shape.x, y=self.shape.y, dir=self.shape.dir})  -- create a new bullet at player position
end

function player:keyboard_input(o)
    self = o

    local function keyboard(event)  -- handle keyboard input for testing
        currentXV, currentYV = self.shape:getLinearVelocity()  -- global set the current x and y velocity
        local phase = phases[event.phase]
        if event.keyName == "w" and event.phase == 'down' then
            self:jump()
        end
        if event.keyName == "d" then
            self:moveRight(phase)
        end
        if event.keyName == "a"  then
            self:moveLeft(phase)
        end
        if event.keyName == "space" and event.phase == 'down' then
            self:shoot()
        end
    end

    Runtime:addEventListener("key", keyboard)
end


return player


-- loop code to see all elements in table
-- for k,v in pairs(self) do
            -- print(k)
            -- end
            -- print(event.other.tag)

-- TODO:
-- add health counter
-- add score? 
-- make better sprites
-- remove and delete items when scene is destroyed
-- add bad guys