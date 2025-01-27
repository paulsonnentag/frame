class_name Draggable
extends Node2D

static var currently_dragged: Node2D

var is_dragging = false
var is_hovered = false

signal dropped(drop_target: Node2D);

@export var drag_handle: Node

func _input(event: InputEvent) -> void:
  if not event.position:
    return

  is_hovered = drag_handle.get_rect().has_point(drag_handle.to_local(event.position))

  if Input.is_action_just_pressed("pointer") and is_hovered and currently_dragged == null:
    currently_dragged = get_parent()
    is_dragging = true
    return

  if currently_dragged != get_parent():
    return

  if Input.is_action_just_released("pointer") and is_dragging:
    is_dragging = false
    currently_dragged = null
    _on_drop(event.position)
    return

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

  if is_dragging:
    parent.global_position = parent.global_position.lerp(get_global_mouse_position(), 0.5)
