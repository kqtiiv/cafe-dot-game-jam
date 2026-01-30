extends Control

@onready var text_label = $storybg/dialogue
@export var type_speed: float = 0.05

func _ready() -> void:
	hide()
	text_label.visible_ratio = 0.0

func display_text(content: String = "...") -> void:
	show()
	GameManager.is_dialogue_active = true 
	text_label.text = content
	text_label.visible_ratio = 0.0
	
	var duration = content.length() * type_speed
	var tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, duration)

func _input(event: InputEvent) -> void:
	if GameManager.is_dialogue_active and event.is_action_pressed("interact"):
		if text_label.visible_ratio < 1.0:
			text_label.visible_ratio = 1.0
		else:
			hide()
			GameManager.is_dialogue_active = false
