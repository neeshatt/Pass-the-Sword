extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var sword_light = $PointLight2D

signal character_killed(character_name: String)
signal sword_retrieved

var is_deadly = false

func _ready():
	sprite.visible = false
	sword_light.visible = false
	is_deadly = false

func _process(delta: float) -> void:
	if sprite.visible:
		sprite.play("sword_animation")

func _on_body_entered(body):
	if body.is_in_group("characters") and is_deadly:
		kill_character(body)
		emit_signal("sword_retrieved")
		hide_sword()
		unfreeze_all_characters()

func kill_character(character):
	if character.has_method("die"):
		character.die()
		emit_signal("character_killed", character.name)

func hide_sword():
	sprite.visible = false
	sword_light.visible = false
	is_deadly = false

func unfreeze_all_characters():
	var characters = get_tree().get_nodes_in_group("characters")
	for character in characters:
		if character.has_method("unfreeze_character"):
			character.unfreeze_character()

func _on_poisonous_weeds_character_frozen() -> void:
	sprite.visible = true
	sword_light.visible = true
	is_deadly = true
