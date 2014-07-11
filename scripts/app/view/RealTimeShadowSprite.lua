--
-- Author: wangbilt@gmail.com
-- Date: 2014-07-11 13:55:51
--

local RealTimeShadowSprite = class("RealTimeShadowSprite", function( filename )
	return display.newSprite(filename)
end)

function RealTimeShadowSprite:ctor( filename )
	self:align(display.CENTER_BOTTOM)

	self.shadow = display.newSprite(filename)
		:align(display.CENTER_BOTTOM)
		:pos(self:getContentSize().width/2, 10)
		:addTo(self,-1)

	self.shadow:setColor(ccc3(0, 0, 0))
	self.shadow:setOpacity(150)
	self.shadow:setRotation(180)
	self.shadow:setFlipX(true)
end

function RealTimeShadowSprite:calculateShadow(l_pos)
	local h  = self:getContentSize().height
	local d_pos = ccp(self:getPositionX(), self:getPositionY() + h)
	local el = l_pos.x - d_pos.x
	local de = l_pos.y - d_pos.y
	local db = h * 2
	local bc = el * db / de

	local acb = 90 - (math.atan2(h, bc) / 3.14 * 180)

	self.shadow:setSkewX(acb)
end

return RealTimeShadowSprite