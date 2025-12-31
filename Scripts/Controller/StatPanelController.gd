extends Node
class_name StatPanelController

const ShowKey:String = "Show"
const HideKey:String = "Hide"

@export var primaryPanel:StatPanel
@export var secondaryPanel:StatPanel

var primaryShow:bool
var secondaryShow:bool

func _ready() -> void:
	primaryPanel.ToAnchorPosition(primaryPanel.GetAnchor(HideKey),false)
	primaryShow = false
	secondaryPanel.ToAnchorPosition(secondaryPanel.GetAnchor(HideKey), false)
	secondaryShow = false

func ShowPrimary(obj:Node):
	primaryPanel.Display(obj)
	if primaryShow == false:
		primaryShow = true
		await primaryPanel.SetPosition(ShowKey,true)

func HidePrimary():
	if primaryShow == true:
		primaryShow = false
		await primaryPanel.SetPosition(HideKey,true)

func ShowSecondary(obj:Node):
	secondaryPanel.Display(obj)
	if secondaryShow == false:
		secondaryShow = true
		await secondaryPanel.SetPosition(ShowKey,true)

func HideSecondary():
	if secondaryShow == true:
		secondaryShow = false
		await secondaryPanel.SetPosition(HideKey,true)
