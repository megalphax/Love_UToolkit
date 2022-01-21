F.CollidersList = {}
F.ColliderGroups = {}

function F.newGameObject(pName, pX, pY)
    local gameobject = {}
    gameobject.name = pName
    gameobject.x = pX
    gameobject.y = pY

    function gameobject:addCollider(pX, pY, pSizeX, pSizeY, pColliderGroup)
        gameobject.collider = {}
        gameobject.collider.x = pX 
        gameobject.collider.y = pY
        gameobject.collider.sizeX = pSizeX
        gameobject.collider.sizeY = pSizeY 
        gameobject.collider.colliderGroup = pColliderGroup

        gameobject.collider.ox = pX - gameobject.x
        gameobject.collider.oy = pY - gameobject.y

        function gameobject.collider:localUpdate(dt)
            gameobject.collider.x = gameobject.x + gameobject.collider.ox + F.camera.offsetX
            gameobject.collider.y = gameobject.y + gameobject.collider.oy + F.camera.offsetX
        end

        function gameobject.collider:localDraw()
            love.graphics.rectangle("line", gameobject.collider.x, gameobject.collider.y, gameobject.collider.sizeX, gameobject.collider.sizeY)
        end

        table.insert(F.CollidersList, gameobject.collider)
    end

    function gameobject:move(pX, pY)
        if gameobject.collider ~= nil then
            for i = 1, #F.CollidersList do 
                local c1 = gameobject.collider
                local c2 = F.CollidersList[i]
                if F.CheckCollision(c1.x, c1.y, c1.sizeX, c1.sizeY, c2.x, c2.y, c2.sizeX, c2.sizeY ) then
                    if F.getCollidersGroupRule(c1.colliderGroup, c2.colliderGroup) ~= "block" then
                        gameobject.x = pX
                        gameobject.y = pY
                    else
                        print("blocked")
                    end
                end
            end
        else 
            gameobject.x = pX
            gameobject.y = pY
        end
    end
    
    return gameobject
end

function F.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end

function F.setColliderGroupRule(pGroup1, pGroup2, pRule)
    local colliderRule = {}
    colliderRule.group1 = pGroup1
    colliderRule.group2 = pGroup2
    colliderRule.rule = pRule
    table.insert(F.ColliderGroups, colliderRule)
end

function F.getCollidersGroupRule(pGroup1, pGroup2)
    for i=1, #F.ColliderGroups do
        if F.ColliderGroups[i].group1 == pGroup1 then
            if F.ColliderGroups[i].group2 == pGroup2 then
                return F.ColliderGroups[i].rule
            end
        end
    end
end