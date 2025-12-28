extends Movement
class_name FlyMovement

func GetTilesInRange(board:BoardCreator):
	var retValue = board.RangeSearch(unit.tile, ExpandSearch, range)
	Filter(retValue)
	return retValue
	
func ExpandSearch(from:Tile,to:Tile):
	return abs(from.pos.x - to.pos.x) + abs(from.pos.y - to.pos.y) <= range

func Traverse(tile:Tile):
	#get distance between unit tile and destination
	var dist:float = sqrt(pow(tile.pos.x - unit.tile.pos.x,2) + pow(tile.pos.y - unit.tile.pos.y,2))
	var dir:Directions.Dirs = Directions.GetDirection(unit.tile, tile)
	unit.Place(tile) 
	
	#fly to prevent clipping
	var y:float = Tile.step_height * 10
	var duration:float = y * 0.25
	
	var tween =create_tween()
	
	tween.tween_property(
		jumper,
		"position",
		Vector3(0,y,0),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	
	#turn to face basic direction
	await Turn(dir)
	
	#move to new tile
	tween = create_tween()
	tween.tween_property(
		unit,
		"position",
		tile.center(),
		dist * 0.5
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	#land on tile
	tween.tween_property(
		jumper,
		"position",
		Vector3(0,0,0),
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
