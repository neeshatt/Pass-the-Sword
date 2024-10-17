extends StaticBody2D

@export var item: InvItem
var player = null

func _on_interactible_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("characters") or body.has_method("collect"):
		player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()

func playercollect():
	player.collect(item)
