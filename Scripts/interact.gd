extends Node3D

@onready var prompt: Label3D = $Prompt
@onready var dialogue: Control = $DialogueUI
@onready var plate: Node3D = $omurice

@export var npc_controller: PathFollow3D 

var player_in_range: bool = false

@onready var anim_player: AnimationPlayer = npc_controller.get_node("armature_004/AnimationPlayer")

func _ready() -> void:
	prompt.visible = false
	plate.visible = false 
	npc_controller.npc_sat_down.connect(_on_npc_sat_down)

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and npc_controller.has_sat_down and event.is_action_pressed("interact"):
		perform_interaction("hi")

func perform_interaction(text: String) -> void:
	prompt.visible = false
	
	if GameManager.current_step != GameManager.CookingStep.SERVE:
		dialogue.display_text("some text")
	else:
		plate.visible = true
		dialogue.display_text(text)
		anim_player.play("eating")
		await anim_player.animation_finished
		
	   
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
