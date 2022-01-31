UTK.CollidersList = {}
UTK.ColliderGroups = {}

function UTK.newGameObject(pName, pX, pY)
    local gameobject = {}
    gameobject.name = pName
    gameobject.x = pX
    gameobject.y = pY

    function gameobject:addCollider(pX, pY, pSizeX, pSizeY, pColliderGroup)
        gameobject.collider = {}
        gameobject.collider.sizeX = pSizeX
        gameobject.collider.sizeY = pSizeY 
        gameobject.collider.colliderGroup = pColliderGroup
        gameobject.collider.triggerFunction = function() end

        gameobject.collider.ox = pX
        gameobject.collider.oy = pY
        gameobject.collider.x = gameobject.x + gameobject.collider.ox
        gameobject.collider.y = gameobject.y + gameobject.collider.oy

        function gameobject.collider:localDraw()
            UTK.graphics.rectangleRelativeToWorld("line", gameobject.collider.x, gameobject.collider.y, gameobject.collider.sizeX, gameobject.collider.sizeY)
        end
        UTK.addLocalDraw(gameobject.collider)

        table.insert(UTK.CollidersList, gameobject.collider)
    end

    function gameobject:move(pX, pY)
        if gameobject.collider ~= nil then

            local canMove = true

            gameobject.collider.x = gameobject.x + gameobject.collider.ox
            gameobject.collider.y = gameobject.y + gameobject.collider.oy

            for i = 1, #UTK.CollidersList do 
                local c1 = gameobject.collider
                local c2 = UTK.CollidersList[i]
                if c1 ~= c2 and UTK.CheckCollision(gameobject.collider.x+pX-gameobject.x, gameobject.collider.y+pY-gameobject.y, c1.sizeX, c1.sizeY, c2.x, c2.y, c2.sizeX, c2.sizeY) then
                    if UTK.getCollidersGroupRule(c1.colliderGroup, c2.colliderGroup) == "block" then
                        canMove = false
                    end
                end
            end

            if canMove then
                gameobject.x = pX
                gameobject.y = pY
            end
        else 

            gameobject.x = pX
            gameobject.y = pY
            
        end
    end
    
    return gameobject
end

function UTK.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end

function UTK.setColliderGroupRule(pGroup1, pGroup2, pRule)
    local colliderRule = {}
    colliderRule.group1 = pGroup1
    colliderRule.group2 = pGroup2
    colliderRule.rule = pRule
    table.insert(UTK.ColliderGroups, colliderRule)
end

function UTK.getCollidersGroupRule(pGroup1, pGroup2)
    for i=1, #UTK.ColliderGroups do
        if UTK.ColliderGroups[i].group1 == pGroup1 then
            if UTK.ColliderGroups[i].group2 == pGroup2 then
                return UTK.ColliderGroups[i].rule
            end
        end
        if UTK.ColliderGroups[i].group1 == pGroup2 then
            if UTK.ColliderGroups[i].group2 == pGroup1 then
                return UTK.ColliderGroups[i].rule
            end
        end
    end
end