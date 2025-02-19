extends Node2D

@onready var draggable: Draggable = %Draggable

@onready var top_card: Sprite2D = %TopCard
@onready var bottom_card: Sprite2D = %BottomCard

@export var reveal_card_on_draw: bool = true

var random = RandomNumberGenerator.new()

var possible_cards: Array[Card] = []

func _ready() -> void:
	print("deck ready")
	draggable.dropped.connect(_on_dropped)

	for child in get_children():
		if child is Card:
			# remove card from parent
			remove_child(child)

			# add card to possible_cards
			possible_cards.append(child)

func _on_dropped(_target: Node2D):
	
	var random_card: Card = possible_cards[random.randi() % possible_cards.size()]

	var card_instance = random_card.duplicate()

	card_instance.is_revealed = reveal_card_on_draw
	get_tree().root.add_child(card_instance)

	card_instance.entity_id = "card_" + get_uuid()
	card_instance.global_position = top_card.global_position
	top_card.global_position = bottom_card.global_position


func get_uuid() -> String:
	var uuid = ""
	for i in range(16):
		if i == 4 or i == 6 or i == 8 or i == 10:
			uuid += "-"
		uuid += "%x" % random.randi_range(0, 15)
	
	return uuid
