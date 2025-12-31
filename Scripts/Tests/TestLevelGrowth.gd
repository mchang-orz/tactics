extends Node

var exiles:Array[Node] = []
var _random = RandomNumberGenerator.new()

func _ready() -> void:
	_random.randomize()
	VerifyLevelToExperienceCalculations()
	VerifySharedExperienceDistribution()

func _exit_tree() -> void:
	for actor in exiles:
		var stats:Stats = actor.get_node("Stats")

		stats.DidChangeNotification(StatTypes.Stat.LVL).disconnect(OnLevelChange)
		stats.WillChangeNotification(StatTypes.Stat.EXP).disconnect(OnExperienceException)

func VerifyLevelToExperienceCalculations():
	for i in range(1,101):
		var expLvl:int = Rank.ExperienceForLevel(i)
		var lvlExp:int = Rank.LevelForExperience(expLvl)
		if(lvlExp != i):
			print("Mismatch on level:{0} with exp:{i} returned:{2}".format([i,expLvl,lvlExp]))
		else:
			print("Level:{0} = Exp:{1}".format([lvlExp,expLvl]))

func VerifySharedExperienceDistribution():
	var party:Array[String] = ["Marauder", "Ranger", "Duelist", "Shadow", "Witch", "Templar", "Scion"]
	
	for exile in party:
		var actor:Node = Node.new()
		actor.name = exile
		self.add_child(actor)
		
		var stats:Stats = Stats.new()
		stats.name = "Stats"
		actor.add_child(stats)
		stats.DidChangeNotification(StatTypes.Stat.LVL).connect(OnLevelChange)
		stats.WillChangeNotification(StatTypes.Stat.EXP).connect(OnExperienceException)
		
		var rank:Rank = Rank.new()
		rank.name = "Rank"
		actor.add_child(rank)
		rank.Init(_random.randi_range(1,4))
		
		exiles.append(actor)
		
	print("===== Before + Experience =====")
	LogParty(exiles)
		
	print("===============================")
	ExperienceManager.AwardExperience(1000, exiles)
		
	print("===== After + Experience =====")
	LogParty(exiles)

func LogParty(party:Array[Node]):
	for actor in party:
		var rank = actor.get_node("Rank")
		print("Name:{0} Level:{1} Exp:{2}".format([actor.name, rank.LVL, rank.EXP]))

func OnLevelChange(sender:Stats, oldValue:int):
	var actor:Node = sender.get_parent()
	print(actor.name + " Leveled Up!")

func OnExperienceException(sender:Stats, vce:ValueChangeException):
	var actor:Node = sender.get_parent()
	var roll:int = _random.randi_range(0, 4)
	match roll:
		0:
			vce.FlipToggle()
			print("{0} would have received {1} experience, but we stopped it".format([actor.name, vce.delta]))
		1:
			vce.AddModifier(AddValueModifier.new(0,1000))
			print("{0} would have received {1} experience, but we added 1000".format([actor.name, vce.delta]))
		2:
			vce.AddModifier(MultDeltaModifier.new(0,2))
			print("{0} would have received {1} experience, but we multiplied by 2".format([actor.name, vce.delta]))
		_:
			print("{0} will receive {1} experience".format([actor.name, vce.delta]))
