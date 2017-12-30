local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('modules.Screen')
local Tiles = require('game.tiles')
local Config = require('game.config')
local Node = require('game.node')

Grid.matrix = {}
Grid.columns = 0
Grid.tileSize = 0
Grid.rows = 0

Grid.setup = function(columns)
    Grid.columns = columns
    Grid.tileSize = Screen.width / Grid.columns
    Grid.rows = math.ceil( ( Screen.height / Grid.tileSize ) + 3 )
end

Grid.setup(Config.tiles)

Grid.create = function (sceneGroup) 

    for i = 0, Grid.rows, 1 do
        Grid.matrix[i] = {} -- nested array right? :)

        for j = 0, Grid.columns-1, 1 do
            local x = (j * Grid.tileSize) + (Grid.tileSize*.5)
            local y = Screen.height - ( Grid.tileSize * (i+1) ) + (Grid.tileSize*.5)

            Grid.matrix[i][j] = Grid.fillSpace(x, y)
            sceneGroup:insert( Grid.matrix[i][j] )
            
            Grid.createOutOfGridObj(x, y)
        end
    end

    return Grid.matrix
end

Grid.addNodesToMatrix = function(matrix)
    local matrix = Grid.matrix or matrix

    for i = 0, Grid.rows, 1 do
        local row = Grid.matrix[i]

        for j= 0, table.getn(row), 1 do
            local block = row[j]

            if row[j-1] then
                
            end
        end

    end

end

Grid.createOutOfGridObj = function(x, y, sceneGroup) 
    local object = ObjectGenerator.randomOutOfGrid()
    local outOfGridOdds = math.random(1, 100)
    
    if outOfGridOdds < 2 then
        local tile = Tiles.create(object, {
            x = x, 
            y = y, 
            tileSize = Grid.tileSize, 
            tables = object.tables
        })
        sceneGroup:insert( tile )
    end
end

Grid.fillSpace = function(x, y) 

    local object = ObjectGenerator.randomInGrid()
    local space = 'empty'

    space = Tiles.create(object, {
        x = x, 
        y = y, 
        tileSize = Grid.tileSize, 
        tables = object.tables
    })

    return space
end

return Grid