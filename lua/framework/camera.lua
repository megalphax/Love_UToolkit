local camera = {}

F.world = {
    x = 0,
    y = 0
}

function F.drawRelativeToWorld(pDrawable, pX, pY, pR, pScaleX, pScaleY, pOriginX, pOriginY)
    local d = {}
    d.x = pX-(currentCamera.x + F.world.x)
    d.y = pY-(currentCamera.y + F.world.y)

    if pR == nil then
        love.graphics.draw(pDrawable, d.x, d.y)
    elseif pScaleX == nil then
        d.scaleX = pScaleX + currentCamera.zoom
        love.graphics.draw(pDrawable, d.x, d.y, pR)
    elseif pScaleY == nil then
        d.scaleY = pScaleY + currentCamera.zoom
        love.graphics.draw(pDrawable, d.x, d.y, pR, d.scaleX)
    elseif pOriginX == nil then
        love.graphics.draw(pDrawable, d.x, d.y, pR, d.scaleX, d.scaleY)
    else
        love.graphics.draw(pDrawable, d.x, d.y, pR, d.scaleX, d.scaleY, pOriginX, pOriginY)
    end
end

function F.createCamera(pX, pY, pScreenSizeX, pScreenSizeY)
    local cam = {}
    cam.x = pX
    cam.y = pY
    cam.sizeX = pScreenSizeX
    cam.sizeY = pScreenSizeY
    cam.zoom = 0

    return cam
end

function F.setCamera(pCam)
    currentCamera = pCam
end

function camera:localUpdate (dt)
    if currentCamera ~= nil then

    end
end

function camera:localDraw()
    if currentCamera ~= nil then
        
    end
end

F.addLocalUpdate(camera)

