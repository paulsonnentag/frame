extends Node

var _godot_project: GodotProject

func _process(_delta: float) -> void:
	_godot_project.process()

func _ready():
	_godot_project = GodotProject.create("4Pbgu8Q634nmXY6TBRGuRk7Jih9c")

	if _godot_project == null:
		print("Failed to create GodotProject instance.")
		return

	await _godot_project.initialized;

	print("SHARED STATE DOC ID: ", _godot_project.get_doc_id())


func get_all_entity_ids() -> PackedStringArray:
	if _godot_project == null:
		return []

	return _godot_project.get_all_entity_ids()

func set_entity_state(entity_id: String, key: String, value: Variant) -> void:
	if _godot_project == null:
		return

	_godot_project.set_entity_state(entity_id, key, value)

func get_entity_state(entity_id, key: String) -> Variant:
	if _godot_project == null:
		return null

	return _godot_project.get_entity_state(entity_id, key)
