
local RealTimeShadowSprite = require("app.view.RealTimeShadowSprite")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newColorLayer(ccc4(255,255,255,255))
        :addTo(self)

    -- sky
    self._sky =  display.newSprite("sky.png")
        :pos(display.width*0.5, display.height*0.5)
        :align(display.CENTER_BOTTOM)
        :addTo(self)
    self._sky:setScale(display.cy / self._sky:getContentSize().height)

    -- sun
    self._sun =  display.newSprite("sun.png")
        :pos(display.width*0.1, display.height*0.9)
        :addTo(self)
    self._sun:runAction(CCRepeatForever:create(CCRotateBy:create(1.0, 90)))

    -- ground
    self._ground =  display.newSprite("ground.png")
        :pos(display.width*0.5, 0)
        :align(display.CENTER_BOTTOM)
        :addTo(self)
    self._ground:setScale(1)

    -- body1
    self._body = RealTimeShadowSprite.new("box.png")
        :align(display.CENTER_BOTTOM)
        :pos(display.cx, display.height*0.25)
        :addTo(self)

    -- body2
     self._body2 = RealTimeShadowSprite.new("win.png")
        :align(display.CENTER_BOTTOM)
        :pos(display.width*0.25, display.height*0.25)
        :addTo(self)
end

function MainScene:onEnter()
    local layer = display.newLayer()
    self:addChild(layer)
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end

    layer:setTouchEnabled(true)
    layer:addTouchEventListener(handler(self, self.onTouchEvent))
end

function MainScene:onTouchEvent(event, x, y)
    self._sun:setPosition(x, y)
    self._body:calculateShadow(ccp(x, y))
    self._body2:calculateShadow(ccp(x, y))
    return true
end

function MainScene:onExit()
end

return MainScene
