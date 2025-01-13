class_name GameTile
extends Tile

@export var texture: Texture2D
@onready var image: Sprite2D = %Sprite2D

func _ready():
  image.texture = texture
