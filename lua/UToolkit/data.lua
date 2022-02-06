UTK.data = {}

function UTK.data.newDataStorage(pMode, pPath, pFilename)
    local DS = {}

        DS.lstData = {}

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
        DS.file = io.open(DS.fullPath, "r")

        function DS:loadFileData()
            DS.fileContent = DS.file:read("*a")
            for line in DS.fileContent:gmatch("([^\n]*)\n?") do
                print(line)
            end
            DS.file:close()
        end

        function DS:addData(pDataType, pName, pContent)
            local data = {}
            data.dataType = pDataType
            data.name = pName
            data.content = pContent
            table.insert(DS.lstData, data)
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

                savedData = savedData .. (dataType.."::"..name.."->"..content..";"..'\n')

            end
            
            io.write(savedData)

            DS.file:close()
        end

    return DS
end
