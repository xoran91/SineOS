local gpu = require("component").gpu
local term = require("term")

local Rendering = {}

function Rendering.drawFrame(_elements)
    for element,value in pairs(_elements) do
    	if(_elements[element].Type == 'Rectangle' or _elements[element].Type == 'TextBlock') then
    		_elements[element]:draw()
        else
    	    for templateElement,value in pairs(_elements[element].ControlTemplate) do
                _elements[element].ControlTemplate[templateElement]:draw()
            end
        end
    end
end

return Rendering