# LoveUToolkit
Main base :

``` lua
local U = require("UToolkit/_utoolkit")

function love.load()
    cam = U.createCamera(0,0, 800, 600)
    U.setCamera(cam)
end

function love.update(dt)
    U.update(dt)
end

function love.draw()
    U.draw()
end
```
