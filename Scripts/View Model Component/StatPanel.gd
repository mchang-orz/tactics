extends LayoutAnchor
class_name StatPanel

@export var allyBackgroundTexture:Texture2D
@export var enemyBackgroundTexture:Texture2D
@export var background:NinePatchRect
@export var avatar:TextureRect
@export var nameLabel:Label
@export var hpLabel:Label
@export var mpLabel:Label
@export var lvlLabel:Label

@export var anchorList:Array[PanelAnchor] = []

func SetPosition(anchorName:String, animated:bool):
	var anchor = GetAnchor(anchorName)
	await ToAnchorPosition(anchor,animated)
	
func GetAnchor(anchorName:String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null

func Display(obj:Node):
	#randomise backgrounds
	background.texture = [allyBackgroundTexture,enemyBackgroundTexture].pick_random()
	#avatar.texture
	
	nameLabel.text = obj.name
	var stats:Stats = obj.get_node("Stats")
	if stats:
		hpLabel.text = "HP {0} / {1}".format([stats.GetStat(StatTypes.Stat.HP), stats.GetStat(StatTypes.Stat.MHP)])
		mpLabel.text = "MP {0} / {1}".format([stats.GetStat(StatTypes.Stat.MP), stats.GetStat(StatTypes.Stat.MMP)])
		lvlLabel.text = "LV. {0}".format([stats.GetStat(StatTypes.Stat.LVL)])
