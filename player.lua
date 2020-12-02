local projectile = require('projectile')
local score = require('score')
local playerHealth = require('playerHealth')
local player = {tag='player'}


local white_cell_frames = {
    frames = {
        { x = 21, y = 719, width = 20, height = 47}, --frame 1 : walk
        { x = 84, y = 719, width = 25, height = 47}, --frame 2 : walk
        { x = 149, y = 719, width = 22, height = 46}, --frame 3 : walk
        { x = 211, y = 719, width = 22, height = 46}, --frame 4 : walk
        { x = 274, y = 719, width = 24, height = 47}, --frame 5 : walk
        { x = 336, y = 719, width= 28, height = 46}, --frame 6 : walk
        { x = 402, y = 719, width= 23, height= 47}, -- frame 7 : walk
        { x = 467, y = 719, width= 22, height= 47}, -- frame 8 : walk
        { x = 532, y = 719, width= 21, height= 47}, -- frame 9 : walk
        { x = 81, y = 207, width= 30, height= 47}, -- frame 10 : jump 
        { x = 17, y = 207, width= 30, height= 47}, -- frane 11 : jump / stand
        { x = 206, y = 207, width= 36, height= 47}, -- frame 12 : jump
        { x = 263, y = 207, width= 50, height= 47}, -- frame 13 : jump
        { x = 328, y = 207, width= 48, height= 47}, -- frame 14 : jump
        { x = 80, y = 463, width= 30, height= 47}, -- frame 15 : shoot
        { x = 465, y = 463, width= 25, height= 47}, -- frame 16 : shoot
        { x = 330, y = 463, width= 42, height= 47}, -- frame 17 : shoot
    }
}
local white_cell_sheet = graphics.newImageSheet("white_cell_guy.png", white_cell_frames)

local action_sequences = {
    {
        name = 'stand',
        frames = {11},
        time = 100,
        loopCount = 1
    },
    {
        name = 'walk',
        frames = {1,2,3,4,5,6,7,8,9},
        time = 1200,
        loopCount = 0
    },
    {
        name = 'jump',
        frames = {10,11,12,13,14},
        time = 700,
        loopCount = 1
    },
    {
        name = 'shoot',
        frames = {15,16,17,17},
        time = 300,
        loopCount = 1
    }
}
currentXV, currentYV = 0, 0
local phases = {down = true, up = false, began = true, ended = false}

local soundTable = {
	shoot = audio.loadSound("shoot.wav"),
	death = audio.loadSound("death.wav")
}

function player:new (o)    --constructor
    o = o or {} 
    setmetatable(o, self)
    self.__index = self
    if o.x and o.y then
        self:spawn(o)
        self:player_input(o)
    end
    return o;
end

function player:spawn(o)
    self = o
    self.shape = display.newSprite(white_cell_sheet, action_sequences);
    self.shape:setSequence('stand')
    self.shape.x = self.x
    self.shape.y = self.y
    self.shape.dir = 1 -- 1 means player facing right ; -1 means player facing left
    self.shape.pp = self
    self.shape.tag = self.tag 
    physics.addBody(self.shape, 'dynamic', {density=10, friction=0.0, bounce=0}) --friction is 0 so that velocity is constant without needing updated, projectiles have density of 0 so they have minimal impact on player sliding
    self.shape.isFixedRotation = true

    local function collisionHandler(shape, event)   -- collision detection
        if event.phase == 'began' then 
            if event.other.tag == 'platform' then  -- if landed on a platform
                self.shape.jumptoggle = true
                -- self.shape:setSequence('stand')
                -- self.shape:play()
            
            elseif event.other.tag == 'projectile' then  -- if hit by a projectile
                -- get shot

            elseif event.other.tag == 'enemy' then  -- if hit by a enemy
                score.add(-10)
                playerHealth.add(-1)
                if playerHealth.get() == 0 then
                    self:gameOver()
                    self:delete()
                end
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
        self.shape:setSequence('walk')
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
        self.shape:setSequence('walk')
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
    self.shape:setSequence('shoot')
    self.shape:play()
    bullet = projectile:new({x=self.shape.x, y=self.shape.y, dir=self.shape.dir})  -- create a new bullet at player position
	audio.play(soundTable["shoot"]); -- play shooting audio
end


function player:gameOver()
    finalScreen = display.newRect(0,0,2*display.contentWidth+60,display.contentWidth+125)
    finalScreen:setFillColor(0,0,0) -- Completly dark
    text = display.newText("GAME OVER", 150, 100, native.systemFont, 40)
    text:setFillColor(1,1,1)
end

function player:player_input(o)
    self = o
    left = display.newRect(0,0,display.contentHeight,display.contentWidth+125)
    left:setFillColor(1,0,0,0) -- Mostly transparent

    centerTop = display.newRect(display.contentWidth/2,0,display.contentWidth/3,display.contentHeight)
    centerTop:setFillColor(0,1,0,0) -- Mostly transparent

    centerBottom = display.newRect(display.contentWidth/2,display.contentHeight,display.contentWidth/3,display.contentHeight)
    centerBottom:setFillColor(0,0,1,0) -- Mostly transparent

    right = display.newRect(display.contentWidth/1.2,0,(display.contentWidth/3)+60,display.contentWidth+125)
    right:setFillColor(0,1,1,0) -- Mostly transparent 

    function keyboard(event)  -- handle keyboard input for testing
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

    function jump(event)
        currentXV, currentYV = self.shape:getLinearVelocity()
        self:jump()
    end

    function moveLeft(event)
        phase = phases[event.phase]
        self:moveLeft(phase)
    end

    function moveRight(event)
        phase = phases[event.phase]
        self:moveRight(phase)
    end

    function shoot(event)
        currentXV, currentYV = self.shape:getLinearVelocity()
        self:shoot()
    end
    Runtime:addEventListener("key", keyboard)
    left:addEventListener("touch", moveLeft)
    centerTop:addEventListener("touch", jump)
    centerBottom:addEventListener("tap",shoot)
    right:addEventListener("touch",moveRight)
end


function player:delete()
    print('deleting player')
    right:removeSelf()
    left:removeSelf()
    centerTop:removeSelf()
    centerBottom:removeSelf()
    Runtime:removeEventListener("key", keyboard)
    left:removeEventListener("touch", moveLeft)
    centerTop:removeEventListener("touch", jump)
    centerBottom:removeEventListener("tap",shoot)
    right:removeEventListener("touch",moveRight)
    self.shape:removeSelf()
	self = nil
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
