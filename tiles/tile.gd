class_name Tile
extends Node2D

@onready var drop_target: DropTarget = %DropTarget
@onready var color_rect: ColorRect = %ColorRect


func _process(_delta: float) -> void:
	color_rect.color.a = 0.5 if drop_target.is_dragging_over else 1.0
