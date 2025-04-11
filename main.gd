extends Node2D

@onready var godot_project = %GodotProject
@onready var reset_game_button = %ResetGameButton
@onready var loading_label = %LoadingLabel
@onready var game = %Game

func _ready() -> void:
	game.visible = false
	loading_label.visible = true

	print("wait")
	await godot_project.checked_out_branch
	print("loaded")

	loading_label.visible = false
	game.visible = true

	Global.register_godot_project(godot_project)

	reset_game_button.pressed.connect(func():
		Global.destroy_all_entities()
	)
