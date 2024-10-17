extends Node2D
class_name Main_Scene

@onready var main_camera: Camera2D = $MainCamera
var selected_character: CharacterBody2D = null
var dead_characters: Array = []
var living_characters: Array[CharacterBody2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)
	if main_camera == null:
		print("Error: MainCamera is not found.")
	else:
		print("MainCamera is set correctly.")
		
	var temp_characters: Array[CharacterBody2D] = []
	for node in get_tree().get_nodes_in_group("characters"):
		if node is CharacterBody2D:
			temp_characters.append(node as CharacterBody2D)
	
	living_characters = temp_characters
	
	var sword = get_node("Sword")  # Adjust the path if necessary
	if sword:
		sword.connect("character_killed", Callable(self, "_on_character_killed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func select_character(character: CharacterBody2D):
	if character.name in dead_characters:
		print("Cannot select dead character:", character.name)
		return


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
		
func _on_character_killed(character_name: String):
	if character_name not in dead_characters:
		dead_characters.append(character_name)
	 # Find the dead character node and distribute their inventory
		var dead_character: CharacterBody2D
		for char in living_characters:
			if char.name == character_name:
				dead_character = char
				break
				
		if dead_character:
			distribute_inventory(dead_character)
			# Remove from living characters array
			living_characters.erase(dead_character)
			
		print("Updated dead characters list:", dead_characters)
		if selected_character and selected_character.name == character_name:
			deselect_character()

func is_character_dead(character_name: String) -> bool:
	return character_name in dead_characters
	
func distribute_inventory(dead_character: CharacterBody2D):
	# Create a new array for recipients
	var recipients: Array[CharacterBody2D] = []
	for char in living_characters:
		if char != dead_character:
			recipients.append(char)
	
	if recipients.is_empty():
		print("No living characters to distribute inventory to!")
		return
	
	# For each living character, give them ALL items from dead character
	for recipient in recipients:
		# Go through each slot in dead character's inventory
		for slot in dead_character.inventory.slots:
			if slot.item != null and slot.amount > 0:
				# Give the exact same number of items to the recipient
				for i in range(slot.amount):
					recipient.collect(slot.item)
		
		print(recipient.name + " received all items from " + dead_character.name)
