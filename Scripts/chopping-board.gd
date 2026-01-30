extends Node3D

@onready var prompt: Label3D = $Prompt

var player_in_range: bool = false

func _ready() -> void:
	prompt.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		perform_interaction()

func perform_interaction() -> void:
	print("Chopping board")
	

func _on_chopping_area_body_entered(body: Node3D) -> void:
	if body is Player: 
		player_in_range = true
		prompt.visible = true
		# Add a 'pop-in' animation here

func _on_chopping_area_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_range = false
		prompt.visible = false
