local Sprites = require('Sprites.Main')  
local GameTables = require('Game.State').tables

local Config = require('Game.Config')
local scaleSizes = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = .80,
  [6] = .75,
  [7] = .65,
  [8] = .5,
  [9] = .4,
}

return  {
  name = "star",
  collisionType = 'star',
  physics = false,
  consumable = true,
  conductsElectricity = true,
  tables = {
    GameTables.tiles
  },
  physics = {
    type = 'static',
    isSensor = true
  },
  sprite = {
    sheet = Sprites.star.sheet,
    sequence = Sprites.star.sequence,
    scale = scaleSizes[Config.tiles],
    rotation = 0
  }
}