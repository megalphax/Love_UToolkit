UTK.debug = {}
UTK.debug.isActive = false

function UTK.debug.addLocalDraw(pElement)
    if UTK.debug.isActive then
        UTK.addLocalDraw(pElement)
    end
end

function UTK.debug.print(pString)
    if UTK.debug.isActive then
        print(pString)
    end
end