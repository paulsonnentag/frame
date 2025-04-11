class_name Draggable
extends Node2D

static var currently_dragged: Node2D

var has_moved = false;
var is_mouse_down = false
var is_hovered = false

signal dropped(drop_target: Node2D);
signal clicked();

var drag_handle: Node

func _input(event: InputEvent) -> void:
	if !("position" in event):
		return
		

	is_hovered = drag_handle.get_rect().has_point(drag_handle.to_local(event.position))

	if Input.is_action_just_pressed("pointer") and is_hovered and currently_dragged == null:
			currently_dragged = get_parent()
			is_mouse_down = true
			has_moved = false
			return

	if currently_dragged != get_parent():
			return

	if Input.is_action_just_released("pointer") and is_mouse_down:
			is_mouse_down = false
			currently_dragged = null
			if not has_moved:
					clicked.emit()
			else:
					_on_drop(event.position)
			return

	if is_mouse_down:
			has_moved = true
			_on_drag(event.position)

func _on_drag(point: Vector2):
		for target in DropTarget.all_drop_targets:
				target.is_dragging_over = target.has_point(point)


func _on_drop(point: Vector2):
		var was_dropped_on_target = false

		for target in DropTarget.all_drop_targets:
				target.is_dragging_over = false

				if target.has_point(point):
						dropped.emit(target.get_parent())
						target.dropped.emit(get_parent())
						was_dropped_on_target = true
						break

		if !was_dropped_on_target:
				dropped.emit(null)

func _process(_delta: float):
		var parent = get_parent()

		if is_mouse_down && has_moved:
				parent.global_position = parent.global_position.lerp(get_global_mouse_position(), 0.5)

func is_dragging():
		return is_mouse_down && has_moved
