extends Node

@export var childPanel:LayoutAnchor
@export var textLabel:Label
@export var animated:bool

func _ready() -> void:
	for i in 9:
		for j in 9:
			textLabel.text = str("childAnchor:", i, "parentAnchor: ", j)
			
			if animated:
				await childPanel.MoveAnchorToPosition(i,j,Vector2.ZERO,0.5)
				await get_tree().create_timer(0.5).timeout
			else:
				childPanel.SnapAnchor(i,j,Vector2.ZERO)
				await get_tree().create_timer(1).timeout
