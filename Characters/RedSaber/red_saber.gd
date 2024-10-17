extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var character_camera: Camera2D = $Camera2D

@export var speed : int = 500
@export var max_horizontal_speed : int = 300
@export var slow_down_speed : int = 1700

enum State {Idle, Walk, Dead}
var current_state : State
var is_selected = false
var frozen = false
var is_alive

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_alive = true
	current_state = State.Idle
	set_process_input(true)
	add_to_group("characters")
	add_to_group("red_saber")

func _physics_process(delta: float) -> void:
	if current_state == State.Dead:
		return
	if is_selected:
		player_idle(delta)
		player_run(delta)
		input_movement()
		move_and_slide()
		player_animations()
		
func player_idle(delta: float):
	if !is_alive:
		return
	if is_on_floor():
		current_state = State.Idle

func player_run(delta: float):
	if frozen or !is_alive:
		return
	velocity = Vector2()
	var direction = input_movement()
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	if direction.length() > 0:
		current_state = State.Walk
	else:
		current_state = State.Idle

func player_animations():
	if current_state == State.Dead:
		animated_sprite_2d.play("death")
		return
	
	var direction = input_movement()
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Walk and direction.x > 0:
		animated_sprite_2d.play("right")
	elif current_state == State.Walk and direction.x < 0:
		animated_sprite_2d.play("left")
	elif current_state == State.Walk and direction.y > 0:
		animated_sprite_2d.play("down")
	elif current_state == State.Walk and direction.y < 0:
		animated_sprite_2d.play("up")

func input_movement() -> Vector2:
	var direction = Vector2()
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	return direction.normalized()

func freeze_character():
	frozen = true
	velocity = Vector2.ZERO

func unfreeze_character():
	frozen = false

func die():
	velocity = Vector2.ZERO
	current_state = State.Dead
	animated_sprite_2d.scale = Vector2(4, 4)
	animated_sprite_2d.play("death")
	await get_tree().create_timer(2).timeout
	queue_free()
	
func activate_camera():
	if character_camera != null:
		is_selected = true
		character_camera.make_current()
	else:
		print("Error: Cannot activate camera because character_camera is null.")

func deactivate_camera():
	is_selected = false
