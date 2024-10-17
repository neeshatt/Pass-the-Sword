extends Area2D


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var selected_character = MainScene.selected_character
		if selected_character:
			# Teleport the selected character to the entrance position with an offset
			var offset = Vector2(1600, -5500)  # Adjust this offset as needed
			selected_character.global_position = offset
			print("Teleported character:", selected_character.name, "to the entrance.")
