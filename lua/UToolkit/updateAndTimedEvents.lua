UTK.UpdateList = {}
UTK.DrawList = {}
UTK.TimedEvents = {}

function UTK.newTimedEvent(pTime, pEvent)
    local e = {}
    e.event = pEvent
    e.time = pTime
    e.done = false

    function e:update(dt)
        if currentTimer >= e.time then
            e.event()
            e.done = true
        end
    end

    table.insert(UTK.TimedEvents, e)
end

function UTK.addLocalUpdate(pElement)
    local u = {}
    u.element = pElement

    function u:update(dt)
        if u.element ~=nil then
            u.element:localUpdate(dt)
        end
    end

    table.insert(UTK.UpdateList, u)
end

function UTK.addLocalDraw(pElement)
    local d = {}
    d.element = pElement

    function d:draw()
        d.element:localDraw()
    end

    table.insert(UTK.DrawList, d)
end

function UTK.updateAll(dt)

    -- TIMED EVENTS
    for i = 1, #UTK.TimedEvents do
        if UTK.TimedEvents[i] ~= nil then
            UTK.TimedEvents[i]:update(dt)
            if UTK.TimedEvents[i].done == true then
                table.remove(UTK.TimedEvents, i)
            end
        end
    end

    -- UPDATE
    for i = 1, #UTK.UpdateList do
        if UTK.UpdateList[i] ~= nil then
            UTK.UpdateList[i]:update(dt)
        end
    end


end

function UTK.drawAll()

    -- DRAW
    for i = 1, #UTK.DrawList do
        if UTK.DrawList[i] ~= nil then
            UTK.DrawList[i]:draw()
        end
    end


end