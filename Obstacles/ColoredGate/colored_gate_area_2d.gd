extends Area2D

signal gate_reached
signal red_saber_at_gate

func _on_body_entered(body: Node2D) -> void:
	emit_signal("gate_reached")
	if body.is_in_group("red_saber"):
		emit_signal("red_saber_at_gate")
