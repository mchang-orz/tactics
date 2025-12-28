extends Movement
class_name WalkMovement

func ExpandSearch(from:Tile,to:Tile):
	#skip tile if unit does not have the jump height
	if abs(from.height - to.height) > jumpHeight:
		return false
	#skip if the tile searched is occupied
	if to.content != null:
		return false
		
	return super(from, to)	

func Walk(target:Tile):
	var tween = create_tween()
	
	tween.tween_property(
		unit,
		"position",
		target.center(),
		0.5
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished

func Jump(to:Tile):
	var unitTween = create_tween()
	
	unitTween.tween_property(
		unit,
		"position",
		to.center(),
		0.5
	).set_trans(Tween.TRANS_LINEAR)
	
	var jumperTween = create_tween()
	
	jumperTween.tween_property(
		jumper,
		"position",
		Vector3(0,Tile.step_height * 2,0),
		0.25
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	jumperTween.tween_property(
		jumper,
		"position",
		Vector3(0,0,0),
		0.25
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	await unitTween.finished

func Traverse(tile:Tile):
	unit.Place(tile)
	
	#build list of points to target tile
	var targets = []
	while tile != null:
		targets.push_front(tile)
		tile = tile.prev
		
	#move to each waypoint on the way to destination
	for i in range(1, targets.size()):
		var from:Tile = targets[i-1]
		var to:Tile = targets[i]
		
		var dir:Directions.Dirs = Directions.GetDirection(from, to)
		
		if unit.dir != dir:
			 #animation goes here
			await Turn(dir)
		if from.height == to.height:
			#animation goes here
			await Walk(to)
		else:
			#animation goes here
			await Jump(to)
	#return to idle animation
