extends BaseAbilityMenuState

@export var commandSelectionState: State
@export var categorySelectionState: State

static var category:int
var skillGemOptions:Array[String] = ["Heavy Strike", "Infernal Blow"]
var flaskOptions:Array[String] = ["Life Flask", "Mana Flask"]

func Enter():
	super()
	statPanelController.ShowPrimary(turn.actor)
	
func Exit():
	super()
	await statPanelController.HidePrimary()

func LoadMenu():
	if(category == 0):
		menuTitle = "Skill Gems"
		SetOptions(skillGemOptions)
	else:
		menuTitle = "Flasks"
		SetOptions(flaskOptions)
	abilityMenuPanelController.Show(menuTitle, menuOptions)

func Confirm():
	turn.hasUnitActed = true
	if(turn.hasUnitMoved):
		turn.lockMove = true
	_owner.stateMachine.ChangeState(commandSelectionState)

func Cancel():
	_owner.stateMachine.ChangeState(categorySelectionState)

func SetOptions(options:Array[String]):
	menuOptions.clear()
	for entry in options:
		menuOptions.append(entry)
