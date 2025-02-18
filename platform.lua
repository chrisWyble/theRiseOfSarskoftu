sensor = require('sensor')
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
	self.shape:setFillColor(0.7,0.3,0.3)
	if self.w > self.h then 
		w = 5
		h = self.h + 5
		left_bound = self.x - self.w/2 + w/2
		right_bound = self.x + self.w/2 - w/2
		upper_bound = self.y 
		lower_bound = self.y 
	else
		w = self.w + 5
		h = 5
		left_bound = self.x
		right_bound = self.x 
		upper_bound = self.y - self.h/2 + h/2
		lower_bound = self.y + self.h/2 - h/2
	end
	self.left_sensor = sensor:new({x=left_bound, y=upper_bound, w=w, h=h})
	self.right_sensor = sensor:new({x=right_bound, y=lower_bound, w=w, h=h})
	physics.addBody(self.shape, 'static', {friction=1, bounce=0})
end

function platform:delete()
	print('delete platform')
	self.left_sensor:delete()
	self.right_sensor:delete()
	self.shape:removeSelf()
	self = nil
end

return platform

