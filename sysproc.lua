local gpu = require("component").gpu
local term = require("term")
local os = require("os")
local shell = require("shell")
local event = require("event")
local computer = require("computer")
local Controls = require("Controls")
local Rendering = require("Rendering")

--local co = coroutine.create(event_handler)
--coroutine.resume(co)

w,h = gpu.getResolution()
bg = Controls.Rectangle:New(1,1,w,h,0x262626)
Button = Controls.Button:New(1,25,12,3,0x1a1a1a,0x66ff66)
Button.ControlTemplate.Rect = Controls.Rectangle:New(60,1,13,3,0x1a1a1a)
Button.ControlTemplate.Rect.Parent = Button
Button.ControlTemplate.Txt = Controls.TextBlock:New(4,1,'hello')
Button.ControlTemplate.Txt.Parent = Button
function Button:onClick()
    Button.ControlTemplate.Rect.color = Button.pressColor
    computer.beep(120)
end
function Button:onDrop()
    Button.ControlTemplate.Rect.color = Button.color
end

Slider = Controls.Slider:New(40,20,12,3)
Slider.ControlTemplate.Rect = Controls.Rectangle:New(40,20,26,1,0x1a1a1a)
Slider.ControlTemplate.Rect.Parent = Slider
Slider.ControlTemplate.ValueRect = Controls.Rectangle:New(40,20,26,1,0x1a1a1a)
Slider.ControlTemplate.Rect.Parent = Slider
Slider.ControlTemplate.ButRect = Controls.Rectangle:New(40,20,3,1,0x66ccf)
Slider.ControlTemplate.ButRect.Parent = Slider
function Slider.ControlTemplate.ButRect:onDrag(x, y)
    if(x ~= Slider.ControlTemplate.ButRect.x) then    
    Slider.ControlTemplate.ButRect.x = x
    end
    --Slider.ControlTemplate.ButRect.y = y
    Rendering.drawFrame(Controls.handles)
end

bottomRect = Controls.Rectangle:New(1,48,w,3,0x1a1a1a)
puskRect = Controls.Rectangle:New(1,48,6,3,0x66ccff)
MenuRect = Controls.Rectangle:New(1,30,30,18,0x262626)

rect = Controls.Rectangle:New(9,8,17,3,0xcc00cc)
textblock = Controls.TextBlock:New(4, 1, "Zip File!")
textblock.Parent = rect
textblock.ParentControl = rect
-- System loop.
touchedObject = nil
while true do
    term.clear()
    Rendering.drawFrame(Controls.handles)

    local eventData = {event.pull()}
    if eventData[1] == 'touch' and eventData[5] == 0 then
        local x = eventData[3]
        local y = eventData[4]
        for key = #Controls.handles,1,-1 do
            if x>=Controls.handles[key].x and x<=(Controls.handles[key].x + Controls.handles[key].Width) and y>=Controls.handles[key].y and y<=(Controls.handles[key].y + Controls.handles[key].Height) then
                if (Controls.handles) and (Controls.handles[key]) and (Controls.handles[key].onClick()) then
                    Controls.handles[key]:onClick()
                    end
                -- Костыль с false
                if Controls.handles[key].Parent then
                    Controls.handles[key].Parent:onClick()
                end
                Rendering.drawFrame(Controls.handles)
                os.sleep(0.2)
                if Controls.handles[key].Parent then
                    Controls.handles[key].Parent:onDrop()
                end
                touchedObject = Controls.handles[key]
                --computer.pushSignal('drag')
                --computer.pushSignal('drop')
                --Controls.handles[key]:onDrop()
                break
            end
        end
    end
    if eventData[1] == 'drag' then
        local x = eventData[3]
        local y = eventData[4]
        for key = #Controls.handles,1,-1 do
            if x>=Controls.handles[key].x and x<=(Controls.handles[key].x + Controls.handles[key].Width) and y>=Controls.handles[key].y and y<=(Controls.handles[key].y + Controls.handles[key].Height) then
                Controls.handles[key]:onDrag(x, y)
                -- Костыль с false
                if Controls.handles[key].Parent then
                    Controls.handles[key].Parent:onDrag(x, y)
                end
                break
            end
        end
    end
    --if eventData[1] == 'drop' then
        --touchedObject:onDrop()
    --end            
    
    os.sleep(0.01)
end