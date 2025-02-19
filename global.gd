extends Node

var _godot_project: GodotProject

func _process(_delta: float) -> void:
	_godot_project.process()

func _ready():
	_godot_project = GodotProject.create("6JEiLoFoXmY1Js1hAynFL4ejUsw")

	if _godot_project == null:
		print("Failed to create GodotProject instance.")
		return

	await _godot_project.initialized;

	print("SHARED STATE DOC ID: ", _godot_project.get_doc_id())


func entity_set_state_int(entity_id: String, key: String, value: int) -> void:
	if _godot_project == null:
		return

	_godot_project.set_state_int(entity_id, key, value)

func entity_get_state_int(entity_id, key: String) -> Variant:
	if _godot_project == null:
		return null

	return _godot_project.get_state_int(entity_id, key)
