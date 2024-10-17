class_name MainMenu
extends Control


@onready var play: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play
@onready var option: Button = $MarginContainer/HBoxContainer/VBoxContainer/Option
@onready var exit: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit
@onready var option_menu: OptionsMenu = $option_menu as OptionsMenu
@export var start_level = preload("res://Main Scene/main_scene.tscn") as PackedScene
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

func _ready() -> void:
	handle_signals()
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_option_pressed() -> void:
	margin_container.visible = false
	option_menu.set_process(true)
	option_menu.visible = true
	
func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	margin_container.visible = true
	option_menu.visible = false

func handle_signals() -> void :
	play.button_down.connect(on_start_pressed)
	option.button_down.connect(on_option_pressed)
	exit.button_down.connect(on_exit_pressed)
	option_menu.exit_options_menu.connect(on_exit_options_menu)
	
