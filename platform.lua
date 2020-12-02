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
	local left_bound = self.x - self.w/2
	local right_bound = self.x + self.w/2
	self.left_sensor = sensor:new({x=left_bound, y=self.y, w=5, h=self.h})
	self.right_sensor = sensor:new({x=right_bound, y=self.y, w=5, h=self.h})
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

