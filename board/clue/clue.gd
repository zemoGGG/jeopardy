extends Control

signal clue_selected(clue_info)

@onready var background = $Background
@onready var value_label = $ValueLabel
@onready var button = $Button

var category = ""
var clue = ""
var answer = ""
var point_value = 0
var is_used = false

func _ready():
	button.flat = true
	button.connect("pressed", _on_button_pressed)
	
func _on_button_pressed():
	if is_used:
		print("Clue already used")
		return
	
	button.release_focus()
	is_used = true
	button.disabled = true
	value_label.visible = false
	
	var clue_info = {
		"category": category,
		"point_value": point_value,
		"value_text": value_label.text,
		"clue_text": clue,
		"answer": answer,
	}
	
	clue_selected.emit(clue_info)

func set_clue_details(cat, value, clue_text, answer_text):
	category = cat
	point_value = value
	clue = clue_text
	answer = answer_text
	
func reset():
	is_used = false
	button.disabled = false
	value_label.visible = true
	
func _on_clue_selected(clue_info) -> void:
	print("CLUE INFO: ", clue_info)
	switch_to_answer(clue_info['clue_text'], clue_info['answer'])
	
func switch_to_answer(clue: String, answer: String):
	var answer_scene = preload("res://board/clue/answer.tscn").instantiate()
	
	var category_text = answer_scene.find_child("CategoryText")
	category_text.text = category
	var clue_text = answer_scene.find_child("ClueText")
	clue_text.text = clue
	var answer_text = answer_scene.find_child("AnswerText")
	answer_text.text = answer
	
	get_parent().get_parent().add_child(answer_scene)
