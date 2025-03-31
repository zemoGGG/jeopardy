extends Control

var categories = []
var clues = ["test1", "test2", "test3", "test4"]

@onready var ClueScene = preload("res://board/clue/clue.tscn")
@onready var AnswerScene = preload("res://board/clue/answer.tscn")
@onready var clue_manager = ClueManager.new()

func _ready():
	clue_manager.load_clues("res://jeopardy.json")
	categories = clue_manager.categories
	clues = clue_manager.clues
	setup_board()

func setup_board():
	# Setup category labels
	for i in range(6): # 6 categories
		var category_label = get_node("Categories/CategoryCard%s/CategoryLabel" % str(i+1))
		if category_label:
			category_label.text = categories[i]
			
		# Setup clues for each category
		var grid_container = get_node("Cat%sGrid" % str(i+1))
		
		if grid_container:
			# Clear existing children to prevent duplicates
			for child in grid_container.get_children():
				child.queue_free()
				
			for j in range(5): # 5 clues per category
				var clue_instance = ClueScene.instantiate()
				
				var value_label = clue_instance.find_child("ValueLabel")
				var point_value = clues[categories[i]][j]["value"] if categories[i] in clues and j < clues[categories[i]].size() else 0
				value_label.text = "$%d" % point_value
				
				clue_instance.set_clue_details(categories[i], point_value, clues[categories[i]][j]["question"], clues[categories[i]][j]["answer"])
				
				grid_container.add_child(clue_instance)
			
			print("Created clue containers for category %s" % str(i+1))

func _on_reset_button_pressed():
	for i in range(6):
		var grid_container = get_node("Cat%sGrid" % str(i+1))
		
		if grid_container:
			var clues = grid_container.get_children()
			for clue in clues:
				clue.reset()
				
	print("Clues have been reset")
	
func _on_dev_button_pressed() -> void:
	pass
