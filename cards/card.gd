@tool

class_name Card
extends Node2D

@onready var draggable: Draggable = %Draggable
@export var entity_id: String

@export var is_revealed = false

@onready var face_sprite: Sprite2D = %FaceSprite
@onready var back_sprite: Sprite2D = %BackSprite

@export var image: Texture2D:
	set(value):
		image = value
		if face_sprite:
			face_sprite.texture = value

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	if image:
		face_sprite.texture = image

	draggable.dropped.connect(_on_dropped)
	draggable.clicked.connect(_on_click)

func _on_click() -> void:
	is_revealed = !is_revealed

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	back_sprite.visible = !is_revealed

	if !draggable.is_mouse_down:
		var x = Global.state.get_state_int(entity_id, "x")
		var y = Global.state.get_state_int(entity_id, "y")

		if x != 0 || y != 0:
			global_position = Vector2(x, y)


func _on_dropped(_target: Node2D):
	Global.state.set_state_int(entity_id, "x", global_position.x);
	Global.state.set_state_int(entity_id, "y", global_position.y);
