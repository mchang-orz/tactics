extends Node
class_name Equip

var defaultSlots:EquipmentSlots.Slot
var secondarySlots:EquipmentSlots.Slot
var slots:EquipmentSlots.Slot

var _isEquipped:bool

func OnEquip():
	if _isEquipped:
		return
	
	_isEquipped = true
	
	var features:Array[Node] = self.get_parent().get_children()
	
	var filteredArray = features.filter(func(node):return node is Feature)
	for node in filteredArray:
		node.Activate(self.get_parent().get_parent().get_parent())


func OnUnEquip():
	if not _isEquipped:
		return
	
	_isEquipped = false
	
	var features:Array[Node] = self.get_parent().get_children()
	var filteredArray = features.filter(func(node):return node is Feature)
	for node in filteredArray:
		node.Deactivate()
