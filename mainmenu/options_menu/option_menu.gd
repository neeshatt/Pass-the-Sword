class_name OptionsMenu
extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/Button

signal exit_options_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
