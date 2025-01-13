class_name GameCard
extends Card

const GameTileScene = preload("res://game/game_tile.tscn")


@export var text: String
@export var image: Texture2D

@onready var label: Label = %Label
@onready var image_sprite: Sprite2D = %ImageSprite

func _ready():
	super._ready()

	label.text = text
	image_sprite.texture = image

func _on_dropped(target: Node):
	if not target is Tile:
		return
	
	var game_tile: GameTile = GameTileScene.instantiate()
	game_tile.position = target.position
	game_tile.texture = image
	target.get_parent().add_child(game_tile)
	target.queue_free()
	self.queue_free()
