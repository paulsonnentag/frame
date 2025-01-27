extends Node

var state: GodotProject = GodotProject.create("")

func _ready():
  print(state.get_doc_id())