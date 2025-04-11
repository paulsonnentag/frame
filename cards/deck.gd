extends Node2D

@onready var draggable: Draggable = %Draggable

@onready var top_card: Sprite2D = %TopCard
@onready var bottom_card: Sprite2D = %BottomCard

@export var reveal_card_on_draw: bool = true

var random = RandomNumberGenerator.new()

var possible_cards: Array[Card] = []

var cards_by_id: Dictionary = {}

func _ready() -> void:
	draggable.drag_handle = top_card
	draggable.dropped.connect(_on_dropped)

	for child in get_children():
		if child is Card:
			# remove card from parent
			remove_child(child)

			# add card to possible_cards
			possible_cards.append(child)

func _process(_delta: float) -> void:
	for entity_id in Global.get_all_entity_ids():
		if cards_by_id.has(entity_id) || !entity_id.begins_with("card_"):
			continue

		var type = Global.get_entity_state(entity_id, "type")
		var base_card: Card

		for card in possible_cards:
			if card.name == type:
				base_card = card
				break

		if base_card == null:
			continue

		var x = Global.get_entity_state(entity_id, "x")
		var y = Global.get_entity_state(entity_id, "y")

		if x == null || y == null:
			continue

		var card_instance = base_card.duplicate()
		card_instance.entity_id = entity_id
		card_instance.global_position = Vector2(x, y)
		card_instance.is_revealed = reveal_card_on_draw

		get_tree().root.add_child(card_instance)


func _on_dropped(_target: Node2D):

	var random_card: Card = possible_cards[random.randi() % possible_cards.size()]
	var card_instance = random_card.duplicate()
	var card_id = "card_" + get_uuid()

	get_tree().root.add_child(card_instance)

	cards_by_id[card_id] = card_instance

	print("created card", cards_by_id)

	Global.set_entity_state(card_id, "type", random_card.name)

	card_instance.is_revealed = reveal_card_on_draw
	card_instance.entity_id = card_id
	card_instance.global_position = top_card.global_position
	card_instance.persist_position()

	top_card.global_position = bottom_card.global_position


func get_uuid() -> String:
	var uuid = ""
	for i in range(16):
		if i == 4 or i == 6 or i == 8 or i == 10:
			uuid += "-"
		uuid += "%x" % random.randi_range(0, 15)
	
	return uuid
