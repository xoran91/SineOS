local term = require("term")
local event = require("event")
local computer = require("computer")
while true do
local eventData = {event.pull()}
term.clearLine()
term.write(eventData[3])
end