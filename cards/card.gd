class_name Card
extends Node2D

@onready var draggable: Draggable = %Draggable

var initial_position: Vector2

func _ready():
	initial_position = global_position
	draggable.dropped.connect(_on_dropped)

func _process(_delta: float):
	if not draggable.is_dragging:
		global_position = global_position.lerp(initial_position, 0.1)
		scale = scale.lerp(Vector2(1, 1), 0.1)
	else:
		scale = scale.lerp(Vector2(0.5, 0.5), 0.1)

func _on_dropped(_target: Node2D):
	
	pass