extends Control

@export var message_label: Label
@export var message_label_2: Label
@export var result_image: TextureRect

@export var perfect_image: Texture2D
@export var good_image: Texture2D
@export var bad_image: Texture2D

func _ready():
	calculate_and_display()

func calculate_and_display():
	var score = 0
	var total_npcs = GameManager.npc_emotions.size()
	
	# Calculate score
	for i in range(total_npcs):
		if i >= GameManager.correct_emotions.size():
			break
			
		var player_choice = GameManager.npc_emotions[i]
		var correct_answer = GameManager.correct_emotions[i]
		
		if player_choice == correct_answer:
			score += 1
			print([i+1])
		else:
			print([i+1, player_choice, correct_answer])

	
	# Show Image & Message based on performance
	if score == total_npcs:
		message_label.text = "Perfect"
		if perfect_image: result_image.texture = perfect_image
		
	elif score >= 1:
		message_label.text = "Good job!"
		if good_image: result_image.texture = good_image
		
	else:
		message_label.text = "Oh no..."
		if bad_image: result_image.texture = bad_image

func _on_main_menu_button_pressed():
	GameManager.npcs_served = 0
	GameManager.npc_emotions.clear()
	GameManager.current_step = GameManager.CookingStep.TALK_TO_CUSTOMER
	
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
