extends BattleState

@export var cutSceneState: State

func Enter():
	super()
	Init()

func Init():
	var saveFile = _owner.board.savePath + _owner.board.fileName
	_owner.board.LoadMapJSON(saveFile)
	
	var p:Vector2i = _owner.board.tiles.keys()[0]
	SelectTile(p)
	
	SpawnTestUnits()
	TranslationServer.set_locale("en")
	#TranslationServer.set_locale("es")
	#TranslationServer.set_locale("ita")
	#TranslationServer.set_locale("fr")
	
	_owner.cameraController.setFollow(_owner.board.marker)
	_owner.stateMachine.ChangeState(cutSceneState)

func SpawnTestUnits():
	var components = [WalkMovement,FlyMovement,TeleportMovement]
	for i in components.size():
		var unit:Unit = _owner.heroPreFab.instantiate() 
		_owner.add_child(unit)
		
		var p:Vector2i = Vector2i(_owner.board.tiles.keys()[i].x,_owner.board.tiles.keys()[i].y)
		
		unit.Place(_owner.board.GetTile(p))
		unit.Match()
		
		var m = unit.get_node("Movement")
		m.set_script(components[i])
		m.range = 5
		m.jumpHeight = 1
		m.set_process(true)
