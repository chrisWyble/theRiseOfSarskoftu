local projectile = {tag="projectile"};

function projectile:new (o)    --constructor
  o = o or {}; 
  print('new')
  setmetatable(o, self);
  self.__index = self;
  if o.x and o.y and o.dir then
    self:spawn(o)
  end
  return o;
end

function projectile:spawn(o)
    print('bullet')
    self = o
    local xoffset = self.dir * 12
    self.shape = display.newRect(self.x + xoffset, self.y, 5, 5);
    self.shape.pp = self;  -- parent
    self.shape.tag = self.tag; 
    self.shape:setFillColor(0.8, 0.8, 0.2)
    physics.addBody(self.shape, 'dynamic', {friction=1, bounce=0})
    self.shape:setLinearVelocity(600*self.dir, -80)

    function onGround()
        self.shape:removeSelf()
        self.shape = nil
	end
	self.shape.collision = onGround
    self.shape:addEventListener('collision')
    
end


return projectile

