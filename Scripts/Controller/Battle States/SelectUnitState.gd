extends BattleState

@export var commandSelectionState: State
#var index:int = -1

func Enter():
	super()
	ChangeCurrentUnit()

func ChangeCurrentUnit():
	turnController.roundResume.emit()
	SelectTile(turn.actor.tile.pos)
	_owner.stateMachine.ChangeState(commandSelectionState)
	#index = (index + 1) % units.size()
	#turn.Change(units[index])
	#_owner.stateMachine.ChangeState(commandSelectionState)

#placeholder code from testing
#@export var moveTargetState: State
#
#func OnMove(e:Vector2i):
	#var rotatedPoint = _owner.cameraController.AdjustedMovement(e)
	#SelectTile(rotatedPoint + _owner.board.pos)
	#
#func OnFire(e:int):
	#print("Fire" + str(e))
	#if _owner.currentTile != null:
		#var content:Node = _owner.currentTile.content
		#if content != null:
			#_owner.currentUnit = content
			#_owner.stateMachine.ChangeState(moveTargetState)
#
#func Zoom(scroll:int):
	#_owner.cameraController.Zoom(scroll)
	#
#func Orbit(direction: Vector2):
	#_owner.cameraController.Orbit(direction)
