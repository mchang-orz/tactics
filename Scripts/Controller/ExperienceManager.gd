extends Node
class_name ExperienceManager

const minLevelBonus:float = 1.5
const maxLevelBonus:float = 0.5

static func AwardExperience(amount:int, party:Array[Node]):
	#grab list of ranks from party
	var ranks:Array[Rank] = []
	for unit in party:
		var r:Rank = unit.get_node("Rank")
		if( r != null):
			ranks.append(r)
	
	#range of actor level stats
	var min:int = 1000000
	var max:int = -1000000
	
	for rank in ranks:
		min = min(rank.LVL, min)
		max = max(rank.LVL, max)
	
	#determine how much to give based on level
	var weights:Array[float] = []
	weights.resize(ranks.size())
	var summedWeights:float = 0
	
	for i in ranks.size():
		var percent:float = (float)(ranks[i].LVL - min + 1) / (float)(max - min + 1)
		weights[i] = lerp(minLevelBonus, maxLevelBonus, percent)
		summedWeights += weights[i]
		
	#award exp
	for i in ranks.size():
		var subAmount:int = floori((weights[i] / summedWeights) * amount)
		ranks[i].EXP += subAmount
