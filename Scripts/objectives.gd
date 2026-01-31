extends Control

@onready var label: Label = $TopTxt/Label
@onready var hold_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	update_objective_text()
	GameManager.update_hold_ui.connect(_on_hold_ui_updated)
	hold_bar.hide()

func _on_hold_ui_updated(percent: float, is_visible: bool) -> void:
	hold_bar.visible = is_visible
	hold_bar.value = percent

func _process(_delta: float) -> void:
	update_objective_text()

func update_objective_text() -> void:
	var current_step = GameManager.current_step
	var objective_prefix = "Objective: "
	
	match current_step:
		GameManager.CookingStep.TALK_TO_CUSTOMER:
			label.text = objective_prefix + "Talk to the customer"
		GameManager.CookingStep.RICE_COOKER:
			label.text = objective_prefix + "Cook rice (Hold E)"
		GameManager.CookingStep.STOVE:
			label.text = objective_prefix + "Cook eggs (Hold E)"
		GameManager.CookingStep.START_MINIGAME:
			label.text = objective_prefix + "Write a message ~"
