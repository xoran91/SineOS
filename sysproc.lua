local gpu = require("component").gpu
local term = require("term")
local os = require("os")
local shell = require("shell")
local event = require("event")
local controls = require("ctrlslib")
local render = require("render")

w,h = gpu.getResolution()
bg = controls.Rectangle:new(1,1,w,h,0x0d0d0d)
function event_handler()
    --for key,value in pairs(controls.handles) do
        --if(controls.handles[key]) 
    --end
    puskRect = controls.Rectangle:new(1,48,6,3,0x66ffcc)
    while true do
    local eventData = {event.pull()}
    if eventData[1] == 'touch' and eventData[5] == 0 then
        x = eventData[3]
        y = eventData[4]
        if x>=puskRect.x and x<=(puskRect.x + puskRect.width) and y>=puskRect.y and y<=(puskRect.y + puskRect.height) then
            puskRect:onClick()
        end
    end
    end
end
--local co = coroutine.create(event_handler)
--coroutine.resume(co)

w,h = gpu.getResolution()
bg = controls.Rectangle:new(1,1,w,h,0x0d0d0d)
bottomRect = controls.Rectangle:new(1,48,w,3,0x1a1a1a)
puskRect = controls.Rectangle:new(1,48,6,3,0xcc00cc)
MenuRect = controls.Rectangle:new(1,30,30,18,0x262626)

rect = controls.Rectangle:new(9,8,17,3,0xcc00cc)
textblock = controls.TextBlock:new(4, 1, "Zip File!")
textblock.isCentered = true
textblock.parent = rect
textblock.parentControl = rect
-- System loop.
while true do
    term.clear()
    render.drawFrame(controls.handles)

    local eventData = {event.pull()}
    if eventData[1] == 'touch' and eventData[5] == 0 then
        x = eventData[3]
        y = eventData[4]
        for key = #controls.handles,1,-1 do
            if x>=controls.handles[key].x and x<=(controls.handles[key].x + controls.handles[key].width) and y>=controls.handles[key].y and y<=(controls.handles[key].y + controls.handles[key].height) then
                if controls.handles[key]:onClick() ~= nil then
                    controls.handles[key]:onClick()
                end
                if controls.handles[key].controlParent ~= nil then
                    controls.handles[key].controlParent:onClick()
                end
                break
            end
        end
    end
    os.sleep(0.01)
end