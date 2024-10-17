extends Node2D

@onready var main_camera: Camera2D = $MainCamera
var selected_character: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)
	if main_camera == null:
		print("Error: MainCamera is not found.")
	else:
		print("MainCamera is set correctly.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func select_character(character: CharacterBody2D):
	#if character.name in dead_characters:
		#print("Cannot select dead character:", character.name)
		#return

	if main_camera and main_camera.is_current(): 
		print("Deactivating main camera.")
		main_camera.current = false
	
	if selected_character != null:
		selected_character.deactivate_camera()
		selected_character.is_selected = false
	
	selected_character = character
	selected_character.activate_camera()
	selected_character.is_selected = true
	print("Selected character:", selected_character.name)

func deselect_character():
	if selected_character:
		selected_character.deactivate_camera()
		selected_character.is_selected = false
		selected_character = null
	
	if main_camera:
		main_camera.current = true
		print("Reactivating main camera.")
