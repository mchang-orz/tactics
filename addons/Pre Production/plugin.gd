@tool
extends EditorPlugin

var panel
const ToolPanel = preload("res://addons/Pre Production/Pre Production.tscn")

func _enter_tree() -> void:
	panel = ToolPanel.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR,panel)


func _exit_tree() -> void:
	remove_control_from_docks(panel)
	panel.queue_free()
