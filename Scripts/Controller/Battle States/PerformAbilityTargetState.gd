extends BattleState

@export var endFacingState:BattleState
@export var commandSelectionState:BattleState

func Enter():
	super()
	turn.hasUnitActed = true
	if(turn.hasUnitMoved):
		turn.lockMove = true
	await Animate()

func Animate():
	#TODO animation players
	#TODO apply effects etc
	
	TempAttack()
	if (turn.hasUnitMoved):
		_owner.stateMachine.ChangeState(endFacingState)
	else:
		_owner.stateMachine.ChangeState(commandSelectionState)
		
func TempAttack():
	for i in range(0,turn.targets.size()):
		var obj = turn.targets[i].content
		var stats:Stats
		
		if( obj != null):
			stats = obj.get_node("Stats")
		if( stats != null):
			stats.SetStat(StatTypes.Stat.HP, stats.GetStat(StatTypes.Stat.HP) - 15)
			if( stats.GetStat(StatTypes.Stat.HP) <= 0):
				print("KO'd {Unit}!".format({"Unit":obj.name}))
