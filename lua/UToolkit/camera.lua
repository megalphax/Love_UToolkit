UTK.camera = {}
UTK.window = {}
UTK.graphics = {}

UTK.camera.autocenterTextures = true
UTK.camera.offsetX = 0
UTK.camera.offsetY = 0

UTK.window.originalSizeX = 800
UTK.window.originalSizeY = 600
UTK.window.aspectRatioX = 1
UTK.window.aspectRatioY = 1
UTK.window.adjustedSizeX = UTK.window.originalSizeX
UTK.window.adjustedSizeY = UTK.window.originalSizeY

function UTK.window.setMode(pX, pY, pFlags)
    if pFlags == nil then pFlags = {} end
    UTK.window.aspectRatioX = (pX + UTK.window.originalSizeX) / UTK.window.originalSizeX -1
    UTK.window.aspectRatioY = (pY + UTK.window.originalSizeY) / UTK.window.originalSizeY -1
    UTK.window.adjustedSizeX = UTK.window.originalSizeX * UTK.window.aspectRatioX
    UTK.window.adjustedSizeY = UTK.window.originalSizeY * UTK.window.aspectRatioY
    love.window.setMode(pX, pY, pFlags)
end

UTK.world = {
    x = 0,
    y = 0
}

function UTK.graphics.rectangleRelativeToWorld(pDrawmode, pX, pY, pScaleX, pScaleY)

    local r = {}
    r.x = pX*UTK.window.aspectRatioX - UTK.camera.offsetX
    r.y = pY*UTK.window.aspectRatioY - UTK.camera.offsetY

    if pScaleX ~= nil then r.scaleX = pScaleX else r.scaleX = 1 end
    if pScaleY ~= nil then r.scaleY = pScaleY else r.scaleY = 1 end
    
    love.graphics.rectangle(pDrawmode, r.x, r.y, r.scaleX*UTK.window.aspectRatioX, r.scaleY*UTK.window.aspectRatioY)

end

function UTK.graphics.drawRelativeToWorld(pDrawable, pX, pY, pR, pScaleX, pScaleY, pOriginX, pOriginY)
    local d = {}
    d.x = pX*UTK.window.aspectRatioX - UTK.camera.offsetX
    d.y = pY*UTK.window.aspectRatioY - UTK.camera.offsetY

    if pScaleX ~= nil then d.scaleX = pScaleX else d.scaleX = 1 end
    if pScaleY ~= nil then d.scaleY = pScaleY else d.scaleY = 1 end
    if pR ~= nil then d.rotation = pR else d.rotation = 0 end
    if pOriginX ~= nil then d.originX = pOriginX elseif UTK.camera.autocenterTextures == true then d.originX = pDrawable:getWidth()/2 else d.originX = 0 end
    if pOriginY ~= nil then d.originY = pOriginY elseif UTK.camera.autocenterTextures == true then d.originY = pDrawable:getHeight()/2 else d.originX = 0 end
    
    love.graphics.draw(pDrawable, d.x, d.y, d.rotation, d.scaleX*UTK.window.aspectRatioX, d.scaleY*UTK.window.aspectRatioY, d.originX, d.originY)
end

function UTK.graphics.draw(pDrawable, pX, pY, pR, pScaleX, pScaleY, pOriginX, pOriginY)
    local d = {}
    d.x = pX
    d.y = pY

    if pScaleX ~= nil then d.scaleX = pScaleX else d.scaleX = 1 end
    if pScaleY ~= nil then d.scaleY = pScaleY else d.scaleY = 1 end
    if pR ~= nil then d.rotation = pR else d.rotation = 0 end
    if pOriginX ~= nil then d.originX = pOriginX elseif UTK.camera.autocenterTextures == true then d.originX = pDrawable:getWidth()/2 else d.originX = 0 end
    if pOriginY ~= nil then d.originY = pOriginY elseif UTK.camera.autocenterTextures == true then d.originY = pDrawable:getHeight()/2 else d.originX = 0 end
    
    love.graphics.draw(pDrawable, d.x, d.y, d.rotation, d.scaleX*UTK.camera, d.scaleY, d.originX, d.originY)
end

function UTK.createCamera(pX, pY)
    local cam = {}
    cam.x = pX -- Center X
    cam.y = pY -- Center Y

    return cam
end

function UTK.setCamera(pCam)
    currentCamera = pCam
end

function UTK.camera:localUpdate (dt)
    if currentCamera ~= nil then
        UTK.camera.offsetX = (currentCamera.x*UTK.window.aspectRatioX - love.graphics.getWidth()/2) + UTK.world.x
        UTK.camera.offsetY = (currentCamera.y*UTK.window.aspectRatioY - love.graphics.getHeight()/2)+ UTK.world.y
    end
end
UTK.addLocalUpdate(UTK.camera)

--[[
function camera:localDraw()
    if currentCamera ~= nil then

    end
end
]]-- 


