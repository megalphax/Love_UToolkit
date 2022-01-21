F.UpdateList = {}
F.DrawList = {}
F.TimedEvents = {}

function F.newTimedEvent(pTime, pEvent)
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

    table.insert(F.TimedEvents, e)
end

function F.addLocalUpdate(pElement)
    local u = {}
    u.element = pElement

    function u:update(dt)
        if u.element ~=nil then
            u.element:localUpdate(dt)
        end
    end

    table.insert(F.UpdateList, u)
end

function F.addLocalDraw(pElement)
    local d = {}
    d.element = pElement

    function d:draw()
        d.element:localDraw()
    end

    table.insert(F.DrawList, d)
end

function F.updateAll(dt)

    -- TIMED EVENTS
    for i = 1, #F.TimedEvents do
        if F.TimedEvents[i] ~= nil then
            F.TimedEvents[i]:update(dt)
            if F.TimedEvents[i].done == true then
                table.remove(F.TimedEvents, i)
            end
        end
    end

    -- UPDATE
    for i = 1, #F.UpdateList do
        if F.UpdateList[i] ~= nil then
            F.UpdateList[i]:update(dt)
        end
    end


end

function F.drawAll()

    -- DRAW
    for i = 1, #F.DrawList do
        if F.DrawList[i] ~= nil then
            F.DrawList[i]:draw()
        end
    end


end