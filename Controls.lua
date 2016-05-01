local gpu = require("component").gpu
local term = require("term")

local Controls = {}

Controls.handles = {}

local function extended (child, parent)
    setmetatable(child,{__index = parent}) 
end

-- class Element
Controls.Element = {}
Controls.Element.__index=Controls.Element

function Controls.Element:New(_x, _y, _Width, _Height)
    local obj={x = _x, y = _y, Width = _Width, Height = _Height, HorizontalAlignment = 'Left', Parent = false, ControlTemplate = {}, ParentControl = nil, isVisible = true}
    setmetatable(obj,self)
    table.insert(Controls.handles, obj)
    return obj
end

function Controls.Element:draw()
    local x = self.x
    local y = self.y
    local p_x = 0
    local p_y = 0
    local p_w = 160
    local p_h = 50
    if self.Parent then
        local p_x = self.Parent.x
        local p_y = self.Parent.y
        local p_w = self.Parent.Width
        local p_h = self.Parent.Height
    end
    if self.HorizontalAlignment == 'Left' then
        self.x = p_x + x
    end    
    if self.HorizontalAlignment == 'Center' then
        self.x = (p_x + x) + p_w/2 - self.Width/2
    end 
end

function Controls.Element:onClick()
    
end

function Controls.Element:onDrop()

end

function Controls.Element:onDrag(x,y)

end

function Controls.Element:Dispose()

end


-- class TextBlock : Element
Controls.TextBlock={}
Controls.TextBlock.__index=Controls.TextBlock
setmetatable(Controls.TextBlock,Controls.Element)

function Controls.TextBlock:New(_x, _y, _Content)
    local obj = Controls.Element:New(_x , _y, string.len(_Content), 1)
    obj.Type = 'TextBlock'
    obj.Content = _Content
    obj.isCentered = false
    setmetatable(obj,self)
    return obj
end

function Controls.TextBlock:draw()
  	Controls.Element.draw(self)
  	gpu.set(x, y, self.Content)
end 	
 --


-- class Rectangle : Element
Controls.Rectangle={}
Controls.Rectangle.__index=Controls.Rectangle
setmetatable(Controls.Rectangle,Controls.Element)

function Controls.Rectangle:New(_x, _y, _Width, _Height, _color)
    local obj = Controls.Element:New(_x , _y, _Width, _Height)
    obj.Type = 'Rectangle'
    obj.color = _color
    setmetatable(obj,self)
    return obj
end

function Controls.Rectangle:draw()
  	Controls.Element.draw(self)
    gpu.setBackground(self.color)
  	gpu.fill(self.x, self.y, self.Width, self.Height, ' ')
end	
 --

-- class Button : Element
Controls.Button={}
Controls.Button.__index=Controls.Button
setmetatable(Controls.Button,Controls.Element)

function Controls.Button:New(_x, _y, _Width, _Height, _color, _pressColor)
    local obj = Controls.Element:New(_x , _y, _Width, _Height)
    obj.Type = 'Button'
    obj.color = _color
    obj.pressColor = _pressColor
    setmetatable(obj,self)
    return obj
end

-- class Slider : Element
Controls.Slider={}
Controls.Slider.__index=Controls.Slider
setmetatable(Controls.Slider,Controls.Element)

function Controls.Slider:New(_x, _y, _Width, _Height)
    local obj = Controls.Element:New(_x , _y, _Width, _Height)
    obj.Type = 'Slider'
    obj.Value = 35
    setmetatable(obj,self)
    return obj
end

 return Controls