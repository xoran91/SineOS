local gpu = require("component").gpu
local term = require("term")

--w, h = gpu.getResolution()
--gpu.setBackground(0x69FFC6)
local render = {}


function render.foob()
    print('foo')
end

function render.drawFrame(_elements)
    for key,value in pairs(_elements) do
        _elements[key]:draw()  
    end
end

return render