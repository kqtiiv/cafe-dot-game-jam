extends Node3D

@onready var prompt: Label3D = $Prompt
@onready var dialogue: Control = $DialogueUI
@onready var plate: Node3D = $omurice

var anim_player: AnimationPlayer 
var npc_controller: PathFollow3D 
var player_in_range: bool = false

# dialogue state
var is_conversing: bool = false
var current_line_index: int = 0

@export var npc_dialogues: Array[Array] = [
	["Welcome in!", "Thanks. Can't wait to have some good food! 
	I've had quite the day, I hope yours has been better than mine. 
	(they let out a soft sigh) Do you ever feel extra tired on gloomy days? 
	I get extra groggy myself... today is definitely one of those days. 
	Just hoping I can still get some things done later.", "Sorry to hear that. 
	Good thing I have just what you need! 
	Be right back."],
	["Hello!", "Hey... (there's an awkwardly long pause) 
	I'll just have one order of the omurice... thanks.", "Sure thing. 
	One omurice coming right up."],
	["Hi, how are you today?", "I'm doing pretty good. 
	It smells fantastic in here! Makes me feel like I'm at home in my moms kitchen. 
	Now that I think of it, it's been far too long since I've seen her. 
	I wonder if my kids would like her cooking. 
	(their eyes shine with a glint of excitement) 
	I should plan a trip for all of us to go and visit!", "Wow! That sounds like it would be a great time. 
	I'm sure your moms cooking is excellent I can only hope you like mine just as much. 
	I'll go get it started now."]
]

func _ready() -> void:
	prompt.visible = false
	plate.visible = false 

func setup_new_npc(new_node: PathFollow3D):
	npc_controller = new_node
	anim_player = npc_controller.get_node("armature_004/AnimationPlayer")
	
	if not npc_controller.npc_sat_down.is_connected(_on_npc_sat_down):
		npc_controller.npc_sat_down.connect(_on_npc_sat_down)
	
	print("Linked to: ", npc_controller.name)

func _unhandled_input(event: InputEvent) -> void:
	# Ensure the NPC is valid and seated
	if not npc_controller or not npc_controller.has_sat_down or not player_in_range:
		return

	# start the conversation
	if event.is_action_pressed("interact") and not is_conversing:
		start_conversation()
		get_viewport().set_input_as_handled()

	elif event.is_action_pressed("interact") and is_conversing:
		advance_conversation()
		get_viewport().set_input_as_handled()

func start_conversation() -> void:
	is_conversing = true
	current_line_index = 0
	prompt.visible = false
	GameManager.is_dialogue_active = true
	
	show_current_line()

func advance_conversation() -> void:
	var current_script = npc_dialogues[GameManager.npcs_served]
	current_line_index += 1
	
	# Check if we still have lines left
	if current_line_index < current_script.size():
		show_current_line()
	else:
		end_conversation()

func show_current_line() -> void:
	if GameManager.npcs_served < npc_dialogues.size():
		var line_text = npc_dialogues[GameManager.npcs_served][current_line_index]
		dialogue.display_text(line_text)

func end_conversation() -> void:
	is_conversing = false
	dialogue.display_text("") 
	if GameManager.current_step != GameManager.CookingStep.SERVE:
		# Took order, now go cook
		print("Order taken.")
	else:
		trigger_eating_sequence()

func trigger_eating_sequence() -> void:
	plate.visible = true
	
	if anim_player:
		anim_player.play("eating")
		await anim_player.animation_finished
	
		var served_emotion = GameManager.npc_emotions[GameManager.npcs_served]
		var wanted_emotion = GameManager.correct_emotions[GameManager.npcs_served]
		
		if served_emotion == wanted_emotion:
			anim_player.play("happy")
		else:
			anim_player.play("sad")
		await anim_player.animation_finished
		
	GameManager.npcs_served += 1
	plate.visible = false
	GameManager.request_next_npc.emit()
	GameManager.is_dialogue_active = false
	
	GameManager.current_step = GameManager.CookingStep.TALK_TO_CUSTOMER


		
func _on_interact_area_body_entered(body: Node3D) -> void:
	if body is Player: 
		player_in_range = true
		update_prompt_visibility()

func _on_interact_area_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_range = false
		update_prompt_visibility()

func _on_npc_sat_down():
	update_prompt_visibility()

func update_prompt_visibility():
	if player_in_range and npc_controller.has_sat_down:
		prompt.visible = true
	else:
		prompt.visible = false
