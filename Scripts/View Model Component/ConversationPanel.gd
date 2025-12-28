extends LayoutAnchor
class_name ConversationPanel

@export var message:Label
@export var speaker:TextureRect
@export var arrow:Node

@export var anchorList:Array[PanelAnchor] = []

signal finished
var _parent:ConversationController

func _ready() -> void:
	_parent = get_node("../")

func GetAnchor(anchorName:String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null

func Display(sd:SpeakerData):
	speaker.texture = sd.speaker
	speaker.size = speaker.texture.get_size()
	
	#reset anchor points after resize
	speaker.anchors_preset = speaker.anchors_preset
	
	for i in sd.messages.size():
		message.text = tr(sd.messages[i])
		arrow.visible = i + 1 < sd.messages.size()
		await _parent.resume
	
	finished.emit()
