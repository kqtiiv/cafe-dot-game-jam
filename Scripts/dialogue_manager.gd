extends Control

@onready var text_label = $storybg/dialogue
@export var type_speed: float = 0.05
@export var kitchen_position: Vector3 = Vector3(10, 1, 5) 

func _ready() -> void:
	hide()
	text_label.visible_ratio = 0.0
	process_mode = Node.PROCESS_MODE_ALWAYS 

func display_text(content: String = "...") -> void:
	show()
	GameManager.is_dialogue_active = true 
	text_label.text = content
	text_label.visible_ratio = 0.0
	
	var duration = content.length() * type_speed
	var tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, duration)

func _input(event: InputEvent) -> void:
	var is_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	var is_interact = event.is_action_pressed("interact")

	if GameManager.is_dialogue_active and (is_interact or is_click):
		if text_label.visible_ratio < 1.0:
			text_label.visible_ratio = 1.0
		else:
			exit_dialogue()

func exit_dialogue() -> void:
	hide()
	GameManager.is_dialogue_active = false
	begin_cooking()

func begin_cooking() -> void:	
	CookingUI.show()
	if GameManager.current_step == GameManager.CookingStep.TALK_TO_CUSTOMER:
		GameManager.current_step = GameManager.CookingStep.RICE_COOKER
		print("Go to Rice Cooker")
