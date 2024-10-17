extends Area2D

signal character_frozen

func _on_body_entered(body):
	if body.is_in_group("characters"):
		body.freeze_character() # Call a method in the character script to freeze it
		emit_signal("character_frozen")


func _on_sword_sword_retrieved() -> void:
	queue_free()
