UTK.data = {}

function UTK.data.newDataStorage(pMode, pPath, pFilename)
    local DS = {}

        DS.lstData = {}

        DS.keyword1 = " ::::> "
        DS.keyword2 = " <:::: "

        DS.fullPath = ""

        if pMode == "GameFolder" then
            DS.fullPath = love.filesystem.getSourceBaseDirectory( ) .. "/" .. pPath .."/"..pFilename
        elseif pMode == "CustomPath" then
            DS.fullpath = pPath.."/"..pFilename
        end

        print(DS.fullPath)

        DS.file = io.open(DS.fullPath, "a")
        io.output(DS.file)
        DS.file:close()

        function DS:loadFileData()
            DS.file = io.open(DS.fullPath, "r")
            DS.fileContent = DS.file:read("*a")

            local dataType = ""
            local name = ""
            local content = ""
            local startKeyword1, endKeyword1, startKeyword2, endKeyword2, endOfLine = 0
            
            for line in DS.fileContent:gmatch("([^\n]*)\n?") do
                if line ~= "" then
                    startKeyword1, endKeyword1 = string.find(line, DS.keyword1)
                    startKeyword2, endKeyword2 = string.find(line, DS.keyword2)
                    endOfLine = string.len(line)

                    print(string.find(line, DS.keyword1))
                    print(line)

                    print(string.sub(line, 0, startKeyword1-1))
                    print(string.sub(line, endKeyword1+1, startKeyword2-1))
                    print(string.sub(line, endKeyword2+1, endOfLine))

                    DS:addData(string.sub(line, 0, startKeyword1-1), string.sub(line, endKeyword1+1, startKeyword2-1), string.sub(line, endKeyword2+1, endOfLine))
                end
            end

            DS.file:close()
        end

        function DS:addData(pDataType, pName, pContent)
            local exist = false
            for i=1, #DS.lstData do
                if pName == DS.lstData[i].name then
                    exist = true
                end
            end
            if not exist then 
                local data = {}
                data.dataType = pDataType
                data.name = pName
                data.content = pContent
                table.insert(DS.lstData, data)
            end
        end

        function DS:setData(pName, pContent)
            for i=1, #DS.lstData do
                if DS.lstData[i].name == pName then 
                    DS.lstData[i].content = pContent
                end
            end
        end

        function DS:getData(pName)
            for i=1, #DS.lstData do
                if DS.lstData[i].name == pName then 
                    if DS.lstData[i].dataType == "float" or DS.lstData[i].dataType == "int" then return tonumber(DS.lstData[i].content)
                    elseif DS.lstData[i].dataType == "string" then return DS.lstData[i].content
                    elseif DS.lstData[i].dataType == "boolean" or DS.lstData[i].dataType == "bool" then if DS.lstData[i].content == "true" then return true else return false end end
                end
            end
        end

        function DS:save()
            DS.file = io.open(DS.fullPath, "w")
            io.output(DS.file)

            local savedData = ""

            for i=1, #DS.lstData do
                local dataType = DS.lstData[i].dataType
                local name = DS.lstData[i].name
                local content = DS.lstData[i].content

                savedData = savedData .. (dataType..DS.keyword1..name..DS.keyword2..content..'\n')

            end
            
            io.write(savedData)

            DS.file:close()
        end

    return DS
end
