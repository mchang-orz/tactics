extends StatusEffect
class_name HasteStatusEffect

var myStats:Stats
const speedModifier = 2

func _enter_tree() -> void:
	myStats = self.get_parent().get_parent().get_node("Stats")
	if myStats:
		myStats.WillChangeNotification(StatTypes.Stat.CTR).connect(OnCounterWillChange)

func _exit_tree() -> void:
	myStats.WillChangeNotification(StatTypes.Stat.CTR).disconnect(OnCounterWillChange)

func OnCounterWillChange(sender:Unit, exc:ValueChangeException):
	exc.AddModifier(MultDeltaModifier.new(0,speedModifier))
