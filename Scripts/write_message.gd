extends Node3D

@export var required_step: GameManager.CookingStep
@export var next_step: GameManager.CookingStep
@export var hold_time: float = 2.0

@onready var prompt: Label3D = $Prompt
@onready var object: Node3D = $Plate

var player_in_range: bool = false

func _ready() -> void:
	prompt.visible = false


func complete_interaction():
	GameManager.current_step = next_step
	print("Step Complete! Next: ", next_step)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player and GameManager.current_step == required_step: 
		player_in_range = true
	update_prompt_visibility()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player and GameManager.current_step == required_step: 
		player_in_range = false
	update_prompt_visibility()

func update_prompt_visibility():
	if player_in_range and GameManager.current_step == required_step:
		prompt.visible = true
	else:
		prompt.visible = false
