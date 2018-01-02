BehaviorElectricityGenerator = {}
local Grid = require('game.map.Grid')
local Config = require('game.Config')

function conductElectricity(obj)
    if(obj.right ~= nil and obj.right.info.conductsElectricity) then
        -- TODO: replace with electricity obj
        conductElectricity(obj.right)
    end

    if(obj.left ~= nil and obj.left.info.conductsElectricity) then
        -- TODO: replace with electricity obj
        conductElectricity(obj.right)
    end

    return
end

-- removes electricity that is not coming from an electric conductor
-- will find electricity block and search right and left to see if 
-- if it comes from an electric conductor. 
-- It will save each block column number so you don't have to check them again
function removeElectricity(options)

    local row = options.row
    local rowLength = Config.tiles 
    local verifiedBlocks = options.verifiedBlocks or {}

    for i = 0, rowLength, 1 do
        local gridObj = Grid[row][i]

        if(gridObj.info.name == 'Electricity') then
            local result = comesFromConductor(gridObj) --results = {verifiedblocks, conductorFound}

            i = math.max(unpack(result.verifiedBlocks)) + 1 
            if(conductorFound == false) then
                -- TODO: convert all verified tiles to empty spaces w a for loop :-)
            end
        end
        
    end
end

-- return a table of indexes searched and whether they come from a conductor
-- results = {verifiedblocks, conductorFound}
function comesFromConductor(options)
    local obj = options.obj
    local currentColumn = obj.coordinates.column
    local verifiedBlocks = options.verifiedBlocks or {}
    local conductorFound = options.conductorFound or false
    local result

    table.insert(verifiedBlocks, currentColumn)

    if(obj.right.info.name == 'Electricity' and obj.right ~= nil) then
        result = comesFromConductor({
            obj = obj,
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        })
    end

    -- found a conductor but keep searching right to verify blocks
    if(obj.right.info.name == 'ElectricityConductor' and obj.right ~= nil) then
        result = comesFromConductor({
            verifiedBlocks = verifiedBlocks,
            conductorFound = true
        })
    end

    -- end of the line. conductor found = true if we found an electricity conductor along the way
    if(obj.right.info.conductsElectricity == false or obj.right == nil) then
        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        } 
    end

end

BehaviorElectricityGenerator.updateElectricity = function(obj)
    local row = obj.coordinates.row

    conductElectricity(obj)
    removeElectricity({row: row})   
end


return BehaviorElectricityGenerator