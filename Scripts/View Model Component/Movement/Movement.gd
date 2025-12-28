extends Node
class_name Movement

var range:int
var jumpHeight:int
var unit:Unit
var jumper:Node3D

func _init() -> void:
	unit = get_node("../")
	jumper = get_node("../Jumper")

func GetTilesInRange(board:BoardCreator):
	var retValue = board.Search(unit.tile, ExpandSearch)
	Filter(retValue)
	return retValue
	
func ExpandSearch(from:Tile,to:Tile):
	return from.distance + 1 <= range
	
func Filter(tiles:Array):
	for i in range(tiles.size()-1,-1,-1):
		if tiles[i].content != null:
			tiles.remove_at(i)
			
func Traverse(tile:Tile):
	pass

func Turn(dir:Directions.Dirs):
	if unit.dir == Directions.Dirs.SOUTH && Directions.Dirs.WEST:
		unit.rotation_degrees.y = 360
	elif unit.dir == Directions.Dirs.WEST && Directions.Dirs.SOUTH:
		unit.rotation_degrees.y = -90
	
	#animation
	var tween = create_tween()
	unit.dir = dir
	tween.tween_property(
		unit,
		"rotation_degrees",
		Directions.ToEuler(dir),
		0.25
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	
