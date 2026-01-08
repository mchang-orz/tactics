extends Node
class_name BattleController

@export var board: BoardCreator
@export var inputController: InputController
@export var cameraController: CameraController
@export var conversationController: ConversationController
@export var abilityMenuPanelController:AbilityMenuPanelController
@export var turnOrderController:TurnOrderController
@export var statPanelController:StatPanelController
@export var stateMachine: StateMachine
@export var startState: State
@export var heroPreFab: PackedScene

var turn:Turn = Turn.new()
var units:Array[Unit] = []

var currentTile:Tile:
	get: return board.GetTile(board.pos)

func _ready() -> void:
	stateMachine.ChangeState(startState)
