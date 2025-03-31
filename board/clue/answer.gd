extends Control

@onready var background = $Background
@onready var category = $CategoryText
@onready var clue_text = $ClueText
@onready var answer_text = $AnswerText

func _ready():
	answer_text.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		# TODO start clue timer??
		answer_text.visible = true
		
	if Input.is_action_just_pressed("left_mouse_button"):
		# Unable to close clue until answer revealed
		if not answer_text.visible:
			return
		else:
			queue_free()
