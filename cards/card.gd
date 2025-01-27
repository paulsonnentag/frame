@tool

class_name Card
extends Node2D

@onready var draggable: Draggable = %Draggable
@export var entity_id: String

@onready var image_sprite: Sprite2D = %FaceSprite
@export var image: Texture2D:
	set(value):
		image = value
		if image_sprite:
			image_sprite.texture = value

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	if image:
		image_sprite.texture = image

	draggable.dropped.connect(_on_dropped)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if !draggable.is_dragging:
		var x = Global.state.get_state_int(entity_id, "x")
		var y = Global.state.get_state_int(entity_id, "y")

		if x != 0 || y != 0:
			global_position = Vector2(x, y)


func _on_dropped(_target: Node2D):
	Global.state.set_state_int(entity_id, "x", global_position.x);
	Global.state.set_state_int(entity_id, "y", global_position.y);
