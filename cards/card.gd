extends Node2D

var is_selected = false
var initial_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	if is_selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		scale = lerp(scale, Vector2(0.5, 0.5), 0.1)
	else:
		scale = lerp(scale, Vector2(1, 1), 0.1)
		position = lerp(position, initial_position, 10 * delta)

func _on_mouse_entered():
	pass
	# scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	pass
 	#	scale = Vector2(1, 1)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("pointer"):
		is_selected = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("pointer"):
		is_selected = true
