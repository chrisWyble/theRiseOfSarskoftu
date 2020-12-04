local projectile = require('projectile')
local score = require('score')
local playerHealth = require('playerHealth')
local enemy = {tag='enemy'}

local germ_frames = {
        frames = {
            { x = 23, y = 596, width = 20, height = 42}, --frame 1 : walk
            { x = 83, y = 596, width = 25, height = 42}, --frame 2 : walk
            { x = 149, y = 596, width = 22, height = 41}, --frame 3 : walk
            { x = 215, y = 596, width = 22, height = 41}, --frame 4 : walk
            { x = 278, y = 596, width = 24, height = 42}, --frame 5 : walk
            { x = 340, y = 596, width= 28, height = 42}, --frame 6 : walk
            { x = 407, y = 596, width= 23, height= 42}, -- frame 7 : walk
            { x = 471, y = 596, width= 22, height= 42}, -- frame 8 : walk
            { x = 535, y = 596, width= 21, height= 42}, -- frame 9 : walk
        }
    }
local germ_sheet = graphics.newImageSheet("germ_guy.png", germ_frames)
local action_sequences = {
    {
        name = 'stand',
        frames = {1},
        time = 100,
        loopCount = 1
    },
    {
        name = 'walk',
        frames = {1,2,3,4,5,6,7,8,9},
        time = 1500,
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

local soundTable = {
	shoot = audio.loadSound("shoot.wav"),
	death = audio.loadSound("death.wav")
}

function enemy:new (o)    --constructor
    o = o or {} 
    setmetatable(o, self)
    self.__index = self
    if o.x and o.y and o.w and o.h and o.health then
        self:spawn(o)
    end
    return o;
end

function enemy:spawn(o)
    self = o
    -- self.shape = display.newRect(self.x, self.y, self.w,self.h,self.health);
    self.shape = display.newSprite(germ_sheet, action_sequences);
    self.shape:setSequence('walk')
    self.shape:play()
    self.shape.initHealth = self.health -- initial health
    self.shape.health = self.health
    self.shape.x = self.x
    self.shape.y = self.y
    self.shape.dir = -1 -- 1 means enemy facing right ; -1 means enemy facing left
    self.shape.pp = self
    self.shape.tag = self.tag 
    self.shape:setFillColor(0,1,0)
    physics.addBody(self.shape, 'dynamic', {density=5, friction=0, bounce=0}) 
    self.shape.isFixedRotation = true
    self.shape:setLinearVelocity(-15, 0)
    local function collisionHandler(shape, event)   -- collision detection
        if event.phase == 'began' then 
            if event.other.tag == 'platform' then  -- if landed on a platform
                self.shape.jumptoggle = true
            
            elseif event.other.tag == 'sensor' or event.other.tag == 'enemy' then
                currentXV, currentYV = self.shape:getLinearVelocity()
                self.shape:setLinearVelocity(-currentXV, currentXY)
                self.shape:scale(-1,1)

            elseif event.other.tag == 'projectile' then  -- if hit by a projectile
                if self.shape.health == 1 then
                    self.shape:removeSelf()
                    score.add( 100 )
                    score.save()
                    audio.play(soundTable["death"]);
					numEnemies = numEnemies - 1
                end
                self.shape.health = self.shape.health - 1
                self.shape:setFillColor(1-self.shape.health/self.shape.initHealth,(self.shape.health)/self.shape.initHealth,0)
            end 
        end
    end
    self.shape.collision = collisionHandler
    self.shape:addEventListener('collision')
	numEnemies = numEnemies + 1
end


function enemy:shoot()
    bullet = projectile:new({x=self.shape.x, y=self.shape.y, dir=self.shape.dir})  -- create a new bullet at enemy position
	audio.play(soundTable["shoot"]);
end


function enemy:delete()
    print('deleting enemy')
    self.shape:removeSelf()
	self = nil
end



return enemy

