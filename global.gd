extends Node

var _godot_project: GodotProject

func register_godot_project(godot_project: GodotProject):
	_godot_project = godot_project

func get_all_entity_ids() -> PackedStringArray:
	if (!_godot_project):
		return []

	return _godot_project.get_all_entity_ids()

func set_entity_state(entity_id: String, key: String, value: Variant) -> void:
	if (!_godot_project):
		return

	_godot_project.set_entity_state(entity_id, key, value)

func get_entity_state(entity_id, key: String) -> Variant:
	if (!_godot_project):
		return null

	return _godot_project.get_entity_state(entity_id, key)
