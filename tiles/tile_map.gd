extends Node2D

@export var width: int = 10
@export var height: int = 10


var tile = preload("res://tiles/tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	print("added this")

	var square_size = 64 # Assuming a square tile size of 64x64 pixels
	var margin = 2 # Added margin of 2 pixels
	var half_width = width / 2.0
	var half_height = height / 2.0
	
	for i in range(width):
		for j in range(height):
			var tile_instance = tile.instantiate()
			var x = (square_size + margin) * (i - half_width) + margin
			var y = (square_size + margin) * (j - half_height) + margin
			tile_instance.position = Vector2(x, y)
			add_child(tile_instance)

	pass # Replace with function body.
