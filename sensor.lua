local sensor = {tag="sensor"};

function sensor:new (o)    --constructor
	o = o or {}; 
	setmetatable(o, self);
	self.__index = self;
	if o.x and o.y and o.w and o.h then
		self:spawn(o)
	end
	return o;
end

function sensor:spawn(o)
	self = o
	self.shape = display.newRect(self.x, self.y, self.w, self.h);
	self.shape.pp = self;  -- parent
	self.shape.tag = self.tag; 
	self.shape:setFillColor(1,1,1, 0) -- sensor is invisible
	physics.addBody(self.shape, 'static', {isSensor=true})
end

function sensor:delete()
    self.shape:removeSelf()
	self = nil
end

return sensor