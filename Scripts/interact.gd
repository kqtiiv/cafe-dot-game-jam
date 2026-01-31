extends Node3D

@onready var prompt: Label3D = $Prompt
@onready var dialogue: Control = $DialogueUI
@onready var plate: Node3D = $omurice

var anim_player: AnimationPlayer 
var npc_controller: PathFollow3D 
var player_in_range: bool = false

@export var npc_dialogues: Array[String] = ["Hello!", "I'm hungry!", "Best food ever!"]

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
	if npc_controller and player_in_range and npc_controller.has_sat_down:
		if event.is_action_pressed("interact"):
			var text = "Thanks!"
			if GameManager.npcs_served < npc_dialogues.size():
				text = npc_dialogues[GameManager.npcs_served]
			perform_interaction(text)

func perform_interaction(text: String) -> void:
	prompt.visible = false
	
	if GameManager.current_step != GameManager.CookingStep.SERVE:
		dialogue.display_text(npc_dialogues[GameManager.npcs_served])
	else:
		plate.visible = true
		dialogue.display_text(text)
		
		if anim_player:
			anim_player.play("eating")
			await anim_player.animation_finished
	
		if GameManager.npc_emotions[GameManager.npcs_served] == GameManager.correct_emotions[GameManager.npcs_served]:
			anim_player.play("happy")
		else:
			anim_player.play("sad")
		await anim_player.animation_finished
		
		GameManager.npcs_served += 1
		plate.visible = false
		GameManager.request_next_npc.emit()
		GameManager.is_dialogue_active = false

		
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
