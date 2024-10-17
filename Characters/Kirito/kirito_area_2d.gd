extends Area2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var parent = get_parent()
		if parent is CharacterBody2D:
			MainScene.select_character(parent)
