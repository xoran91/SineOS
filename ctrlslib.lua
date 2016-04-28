local gpu = require("component").gpu
local term = require("term")

local ctrlslib = {}
ctrlslib.handles = {}

-- class Element
ctrlslib.Element = {}
ctrlslib.Element.__index=ctrlslib.Element

function ctrlslib.Element:new(_x, _y, _width, _height)
    local obj={x = _x, y = _y, width = _width, height = _height, parent = nil, parentControl = nil, isVisible = true}
    setmetatable(obj,self)
    table.insert(ctrlslib.handles, obj)
    return obj
end

function ctrlslib.Element:draw()
   
end

function ctrlslib.Element:dispose()

end


-- class TextBlock : Element
ctrlslib.TextBlock={}
ctrlslib.TextBlock.__index=ctrlslib.TextBlock
setmetatable(ctrlslib.TextBlock,ctrlslib.Element)

function ctrlslib.TextBlock:new(_x, _y, _text)
    local obj = ctrlslib.Element:new(_x , _y, string.len(_text), 1)
    obj.text = _text
    obj.isCentered = false
    setmetatable(obj,self)
    return obj
end

function ctrlslib.TextBlock:draw()
  	ctrlslib.Element.draw(self)
        x = self.x
        y = self.y
        if self.parent~=nil then
            x = self.x + self.parent.x
            y = self.y + self.parent.y
            if isCentered == true then
                x = x + self.width / 2
            end
        end
  	gpu.set(x, y, self.text)
end 	
 --


-- class Rectangle : Element
ctrlslib.Rectangle={}
ctrlslib.Rectangle.__index=ctrlslib.Rectangle
setmetatable(ctrlslib.Rectangle,ctrlslib.Element)

function ctrlslib.Rectangle:new(_x, _y, _width, _height, _color)
    local obj = ctrlslib.Element:new(_x , _y, _width, _height)
    obj.color = _color 
    setmetatable(obj,self)
    return obj
end

function ctrlslib.Rectangle:onClick()
    -- WINDOW.BUTTON_CLICK_HANDLER()
    self.color = 0x660066
end

function ctrlslib.Rectangle:draw()
  	ctrlslib.Element.draw(self)
        gpu.setBackground(self.color)
  	gpu.fill(self.x, self.y, self.width, self.height, ' ')
end 	
 --
 return ctrlslib