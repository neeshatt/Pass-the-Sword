extends StaticBody2D

var blue_key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blue_key = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal colored_gate_found

func _on_area_2d_gate_reached() -> void:
	emit_signal("colored_gate_found")



func _on_blue_key_key_retrieved() -> void:
	blue_key = true


func _on_area_2d_red_saber_at_gate() -> void:
	if blue_key :
		queue_free()
