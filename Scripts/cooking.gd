extends Node3D

@export var required_step: GameManager.CookingStep
@export var next_step: GameManager.CookingStep
@export var hold_time: float = 2.0

@onready var progress_bar: TextureProgressBar = $ProgressBar 

var is_holding: bool = false
var current_hold_timer: float = 0.0
var player_in_range: bool = false

func _process(delta: float) -> void:
	if player_in_range and GameManager.current_step == required_step:
		if Input.is_action_pressed("interact"):
			is_holding = true
			current_hold_timer += delta
			progress_bar.show()
			progress_bar.value = (current_hold_timer / hold_time) * 100
			
			if current_hold_timer >= hold_time:
				complete_interaction()
		else:
			reset_hold()
	else:
		reset_hold()

func reset_hold():
	is_holding = false
	current_hold_timer = 0.0
	progress_bar.hide()

func complete_interaction():
	GameManager.current_step = next_step
	reset_hold()
	print("Step Complete! Next: ", next_step)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player: player_in_range = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player: player_in_range = false
