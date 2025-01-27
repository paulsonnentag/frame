extends Node

var state: GodotProject = GodotProject.create("3PmJQKaMkfw4yY1hD1PsLnphzsXy")

func _ready():
  print(state.get_doc_id())