UTK = {}

require("UToolkit/updateAndTimedEvents")
require("UToolkit/camera")
require("UToolkit/gameobjects")
require("UToolkit/debug")

function UTK.update(dt)
    UTK.updateAll(dt)
end

function UTK.draw()
    UTK.drawAll()
end

return UTK;