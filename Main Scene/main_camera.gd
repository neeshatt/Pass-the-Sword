extends Camera2D
class_name MainCamera

@export var initial_zoom: Vector2 = Vector2(0.3, 0.3) 

var _previous_position: Vector2 = Vector2()
var _move_camera: bool = false

const zoom_step = 0.1  # How much to zoom in or out with each scroll
const min_zoom = 0.3   # Minimum zoom level
const max_zoom = 1.0   # Maximum zoom level

func _ready():
	make_current()
	
	zoom = initial_zoom  # Apply the zoom level to the camera
	print("MainCamera zoom level set to:", zoom)
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			_previous_position = event.position
			_move_camera = true
			make_current()  # Enable this camera as the active one
			# Set the default zoom level
			zoom =  Vector2(0.3, 0.3)
		else:
			_move_camera = false
	elif event is InputEventMouseMotion and _move_camera:
		var delta = _previous_position - event.position
		position += delta
		_previous_position = event.position
		
		# Zoom in or out based on the mouse wheel movement
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom.x = clamp(zoom.x - zoom_step, min_zoom, max_zoom)
			zoom.y = clamp(zoom.y - zoom_step, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom.x = clamp(zoom.x + zoom_step, min_zoom, max_zoom)
			zoom.y = clamp(zoom.y + zoom_step, min_zoom, max_zoom)
		
		
func _process(delta):
	if _move_camera:
		# Keep this camera current while dragging
		make_current()
