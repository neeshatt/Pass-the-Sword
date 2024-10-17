extends Control

var inv: Inv
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false

func _ready() -> void:
	close()
	
func set_character_inventory(character_inventory: Inv):
	if inv:
		if inv.update.is_connected(update_slots):
			inv.update.disconnect(update_slots)
	
	inv = character_inventory
	if inv:
		inv.update.connect(update_slots)
		update_slots()
	
func update_slots():
	if !inv:
		return
	for i in range(min(inv.slots.size(), slots.size())):
		var inv_item = inv.slots[i]
		slots[i].update(inv_item)
	
func close():
	visible = false
	is_open = false
	
func open():
	self.visible = true
	is_open = true
