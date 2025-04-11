extends Node2D

@onready var godot_project = %GodotProject

func _ready() -> void:
	print(godot_project)
	print("wait")
	await godot_project.checked_out_branch
	print("loaded")

	Global.register_godot_project(godot_project)
