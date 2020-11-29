local platform = {tag="platform"};

function platform:new (o)    --constructor
	o = o or {}; 
	setmetatable(o, self);
	self.__index = self;
	if o.x and o.y and o.w and o.h then
		self:spawn(o)
	end
	return o;
end

function platform:spawn(o)
	self = o
	self.shape = display.newRect(self.x, self.y, self.w, self.h);
	self.shape.pp = self;  -- parent
	self.shape.tag = self.tag; 
	self.shape:setFillColor(0.1,0.5,0)
	physics.addBody(self.shape, 'static', {friction=1, bounce=0})
end

return platform

