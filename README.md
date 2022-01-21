# LoveUToolkit
Main base :

``` lua
local framework = require("UToolkit/_UToolkit")

function love.load()
    cam = framework.createCamera(0,0, 800, 600)
    framework.setCamera(cam)
end

function love.update(dt)
    framework.update(dt)
end

function love.draw()
    framework.draw()
end
```
