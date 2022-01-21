F.camera = {}

F.camera.autocenterTextures = true
F.camera.offsetX = 0
F.camera.offsetY = 0

F.world = {
    x = 0,
    y = 0
}

function F.drawRelativeToWorld(pDrawable, pX, pY, pR, pScaleX, pScaleY, pOriginX, pOriginY)
    local d = {}
    d.x = pX - F.camera.offsetX
    d.y = pY - F.camera.offsetY

    if pScaleX ~= nil then d.scaleX = pScaleX else d.scaleX = 1 end
    if pScaleY ~= nil then d.scaleY = pScaleY else d.scaleY = 1 end
    if pR ~= nil then d.rotation = pR else d.rotation = 0 end
    if pOriginX ~= nil then d.originX = pOriginX elseif F.camera.autocenterTextures == true then d.originX = pDrawable:getWidth()/2 else d.originX = 0 end
    if pOriginY ~= nil then d.originY = pOriginY elseif F.camera.autocenterTextures == true then d.originY = pDrawable:getHeight()/2 else d.originX = 0 end
    
    love.graphics.draw(pDrawable, d.x, d.y, d.rotation, d.scaleX, d.scaleY, d.originX, d.originY)
end

function F.createCamera(pX, pY, pScreenSizeX, pScreenSizeY)
    local cam = {}
    cam.x = pX -- Center X
    cam.y = pY -- Center Y
    cam.sizeX = pScreenSizeX
    cam.sizeY = pScreenSizeY

    return cam
end

function F.setCamera(pCam)
    currentCamera = pCam
end

function F.camera:localUpdate (dt)
    if currentCamera ~= nil then
        F.camera.offsetX = (currentCamera.x - currentCamera.sizeX/2) + F.world.x
        F.camera.offsetY = (currentCamera.y - currentCamera.sizeY/2)+ F.world.y
    end
end
F.addLocalUpdate(F.camera)

--[[
function camera:localDraw()
    if currentCamera ~= nil then

    end
end
]]-- 


