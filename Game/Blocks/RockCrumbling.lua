local GameTables = require('Game.Tables')

return {
  name = "rockTileCrumbling",
  collisionType = 'rockCrumbling',
  conductsElectricity = false,
  blocksElectricity = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}