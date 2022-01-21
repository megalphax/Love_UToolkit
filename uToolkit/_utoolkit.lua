F = {}

require("framework/updateAndTimedEvents")
require("framework/camera")
require("framework/gameobjects")

function F.update(dt)
    F.updateAll(dt)
end

function F.draw()
    F.drawAll()
end

return F;