extends Node
class_name ClueManager

var categories = {}
var clues = {}

func load_clues(config_path: String):
	var file = FileAccess.open(config_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var data = JSON.parse_string(content)
		if data:
			categories = data.keys()
			clues = data
		else:
			print("Error opening config file")
		file.close()
	else:
		print("Failed to open file: " + config_path)
		
func get_clue(category: String, index: int):
	if category in clues and index >= 0 and index < clues[category].size():
		return clues[category][index]
	return {}
	
func print_clues():
	for category in categories:
		print("Category: " + category)
		for clue in clues[category]:
			print("  Clue: ", clue["question"], "  |  Answer: ", clue["answer"], "  |  Value: ", clue["value"])
