extends Node3D
class_name Unit

var tile:Tile
var dir:Directions.Dirs = Directions.Dirs.SOUTH

func Place(target:Tile):
	#make sure old tile is not pointed to unit still
	if tile != null && tile.content == self:
		tile.content = null
	#Link unit and target
	tile = target
	
	if target != null:
		target.content = self

func Match():
	self.position = tile.center()
	self.rotation_degrees = Directions.ToEuler(dir)
