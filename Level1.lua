local composer = require( "composer" )
	  composer.removeScene( "Menu" )
local scene = composer.newScene()



function scene:create( event )
	local sceneGroup = self.view
	movableGroup = display.newGroup()
	staticGroup = display.newGroup()

	Inspect = require('Libraries.Inspect')
	AppState = require('Game.State')
	Config = require('Game.config')
	EventListeners = require('EventListeners.main')
	Graphics = require('UI.GraphicEffects')
	Grid = require('Game.Map.Grid')
	Player = require('Game.Player')
	PhysicsMain = require('Physics.Main')
	Math = require('Utils.math')
	Node = require('Game.Map.Node')
	RowBehaviors = require('Game.Behaviors.Row')
	LevelMenu = require('Menus.LevelMenu')
	LevelData = require('Game.Data.LevelData')
	Screen = require('Device.Screen')
	Sprites = require('Sprites.Main')
	Table = require('Utils.Table')

	physics = require 'physics'
	physics.start()
	physics.setGravity( 0, 9.81)  -- 9.81 m/s*s in the positive x direction  

	AppState.init()
	AppState.setSceneGroup(sceneGroup)
	print( Inspect(Grid) )

	-- Create Grid
	local levelData = LevelData.getLevelData()
	Grid.init(Config.tiles)
	Grid.create(levelData)
	Grid.updateUI()


	PhysicsMain.createBounds({
		onSides = {'right', 'left'}
	})
	
	player = Player.new(AppState.tileSize)
	LevelMenu.initControls()

	if(Config.levelBuilder.activated) then
		local LevelBuilder = require('LevelBuilder.main')
		LevelBuilder.initControls()
		if(Config.levelBuilder.resetLevel) then
			LevelBuilder.resetLevelData()
		end
	end
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then	

	elseif phase == "did" then

		local gameViewLayers = {
			[1] = itemsGroup,
			[2] = blackTiles,
			[3] = player,
			[4] = orbText,
			[5] = player
		}
		RuntimeMain = require('Runtime.Main')
		RuntimeMain.init({
			ZOrderGroups = gameViewLayers
		})
		EventListeners.init()


	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		RuntimeMain.removeAll()
		EventListeners.removeAll()
		Grid.reset()

		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene