local projectile = {tag="projectile"};

function projectile:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  if o.x and o.y and o.dir then
    self:spawn(o)
  end
  return o;
end

function projectile:spawn(o)
    self = o
    local xoffset = self.dir * 12
    self.shape = display.newRect(self.x + xoffset, self.y, 5, 5);
    self.shape.pp = self;  -- parent
    self.shape.tag = self.tag; 
    self.shape:setFillColor(0.8, 0.8, 0.2)
    physics.addBody(self.shape, 'dynamic', {density=0, friction=0, bounce=1})
    self.shape.isBullet = true  -- bullet means collision detection occurs more frequently
    self.shape.gravityScale = 0  -- 0 gravity so that it does not fall
    self.shape:setLinearVelocity(500*self.dir, 0)  -- velocity 500 in the direction player is facing

    function collisionHandler()
        self.shape:removeSelf()
        self.shape = nil
	end
	self.shape.collision = collisionHandler
    self.shape:addEventListener('collision')
    
end


return projectile

