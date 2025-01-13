class_name DropTarget
extends Node2D

var is_dragging_over = false

@export var drop_handle: Node

static var all_drop_targets = []

signal dropped(draggable: Node2D)

func has_point(point: Vector2) -> bool:
	var local_point = get_parent().to_local(point)
	return drop_handle.get_rect().has_point(local_point)

func _ready() -> void:
	if drop_handle == null:
		push_warning("drop_handle is not defined. Please assign a Node2D to drop_handle.")

func _enter_tree() -> void:
	print("enter")
	all_drop_targets.append(self)

func _exit_tree() -> void:
	all_drop_targets.erase(self)
