extends Area2D

@onready var sprite = $Sprite2D
@onready var bluekey_light = $PointLight2D

var is_picked_up = false
signal key_retrieved

func _ready():
	sprite.visible = false
	bluekey_light.visible = false

func _on_body_entered(body):
	if is_picked_up:
		return # Prevent multiple pickups
	if body.is_in_group("blue_elf"):
		# Reparent the key to the blue elf
		self.get_parent().remove_child(self)
		body.add_child(self)
		# Optionally, change the position to align with the character
		self.position = Vector2(0, -90) # Adjust this offset if needed
		is_picked_up = true
		emit_signal("key_retrieved")

func _on_colored_gate_colored_gate_found() -> void:
	sprite.visible = true
	bluekey_light.visible = true
