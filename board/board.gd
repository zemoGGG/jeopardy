extends Control

var categories = []
var clues = []

func _ready():
	categories = ['Big Booty Latinas', 'Test1', 'Test2', 'Test3', 'Test4', 'Test5']
	setup_game()
	
	
func setup_game():
	# Setup categories
	for i in range(6):
		var category_label = get_node("Categories/CategoryCard%s/CategoryLabel" % str(i+1))
		if category_label:
			category_label.text = categories[i]
