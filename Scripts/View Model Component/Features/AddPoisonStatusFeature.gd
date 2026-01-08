extends AddStatusFeature
class_name AddPoisonStatusFeature

func _ready() -> void:
	statusEffect = PoisonStatusEffect
	statusString = "Poison"
	conditionString = "Status Condition"
