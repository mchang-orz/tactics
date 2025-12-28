extends Node

@export var childPanel:LayoutAnchor
@export var vbox: VBoxContainer
@export var animated:bool

@export var anchorList:Array[PanelAnchor] = []

func GetAnchor(anchorName:String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null

func AnchorButton(text:String):
	var anchor = GetAnchor(text)
	if anchor:
		childPanel.ToAnchorPosition(anchor,animated)
	else:
		print("Anchor null")

func _ready() -> void:
	#button setup
	var buttonShow = Button.new()
	buttonShow.text = "show"
	buttonShow.pressed.connect(AnchorButton.bind("show"))
	vbox.add_child(buttonShow)
	
	var buttonHide = Button.new()
	buttonHide.text = "hide"
	buttonHide.pressed.connect(AnchorButton.bind("hide"))
	vbox.add_child(buttonHide)
	
	var buttonCenter = Button.new()
	buttonCenter.text = "center"
	buttonCenter.pressed.connect(AnchorButton.bind("center"))
	vbox.add_child(buttonCenter)
	
	#add center anchor to list
	var anchorCenter:PanelAnchor = PanelAnchor.new()
	anchorCenter.SetValues("center",Control.PRESET_CENTER, Control.PRESET_CENTER, Vector2.ZERO, 0.5, Tween.TRANS_BACK)
	anchorList.append(anchorCenter)
