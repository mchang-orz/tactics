extends Node
class_name ConversationController

signal completeEvent()
signal resume()

@export var leftPanel:ConversationPanel
@export var rightPanel:ConversationPanel

var inTransition:bool

func _DisableNode(node:Node) -> void:
	node.process_mode = Node.PROCESS_MODE_DISABLED
	node.hide()

func _EnableNode(node:Node) -> void:
	node.process_mode = Node.PROCESS_MODE_INHERIT
	node.show()

func _ready() -> void:
	leftPanel.ToAnchorPosition(leftPanel.GetAnchor("Hide Bottom"), false)
	_DisableNode(leftPanel)
	
	rightPanel.ToAnchorPosition(rightPanel.GetAnchor("Hide Bottom"), false)
	_DisableNode(rightPanel)

func Show(data:ConversationData):
	_EnableNode(leftPanel)
	_EnableNode(rightPanel)
	Sequence(data)

func Next():
	if not  inTransition:
		resume.emit()

func Sequence(data:ConversationData):
	for sd in data.list:
		inTransition = true
		var currentPanel:ConversationPanel
		if(sd.anchor == Control.PRESET_TOP_LEFT || sd.anchor == Control.PRESET_BOTTOM_LEFT || sd.anchor == Control.PRESET_CENTER_LEFT):
			currentPanel = leftPanel
		else:
			currentPanel = rightPanel
		
		var show:PanelAnchor
		var hide:PanelAnchor
		
		if(sd.anchor == Control.PRESET_TOP_LEFT || sd.anchor == Control.PRESET_TOP_RIGHT || sd.anchor == Control.PRESET_CENTER_TOP):
			show = currentPanel.GetAnchor("Show Top")
			hide = currentPanel.GetAnchor("Hide Top")
		else:
			show = currentPanel.GetAnchor("Show Bottom")
			hide = currentPanel.GetAnchor("Hide Bottom")
		
		#make sure panel is hidden initially, text is set to initial
		currentPanel.ToAnchorPosition(hide,false)
		currentPanel.Display(sd)
		
		#move panel, wait
		await currentPanel.ToAnchorPosition(show,true)
		
		#allow dialogue advancement
		inTransition = false
		await currentPanel.finished
		
		#hide panel, wait
		inTransition = true
		await currentPanel.ToAnchorPosition(hide,true)
	
	_DisableNode(leftPanel)
	_DisableNode(rightPanel)
	completeEvent.emit()
