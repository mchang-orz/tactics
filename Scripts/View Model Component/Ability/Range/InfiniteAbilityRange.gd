extends AbilityRange
#simple ver
#func GetTilesInRange(board:BoardCreator):
	#return board.tiles.values()

#calculator....
enum Calc {
	ALL,
	HEIGHT,
	PRIME
}

@export var option:Calc = Calc.ALL

func GetTilesInRange(board:BoardCreator):
	if option == Calc.ALL:
		return board.tiles.values()
	else:
		var retValue:Array[Tile] = []
		for tile in board.tiles.values():
			if ValidTile(tile):
				retValue.append(tile)
		return retValue
		
func ValidTile(t:Tile):
	match option:
		Calc.HEIGHT:
			if t.content != null:
				if t.height % 2 == 0:
					return true
		Calc.PRIME:
			if t.content != null:
				IsPrime(t.content)
		_:
			return false
	return false

func IsPrime(obj:Node):
	var stats:Stats = obj.get_node("Stats")
	if stats:
		var unitLvl:int = stats.GetStat(StatTypes.Stat.LVL)
		#check divisors
		if unitLvl == 1:
			return false
		elif unitLvl == 2:
			return true
		else:
			for i in range(2, unitLvl):
				if unitLvl % i == 0:
					return false
		return true
