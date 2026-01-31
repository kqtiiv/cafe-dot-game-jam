extends Node
var is_dialogue_active: bool = false

enum CookingStep { TALK_TO_CUSTOMER, RICE_COOKER, STOVE, START_MINIGAME, SERVE }
var current_step: CookingStep = CookingStep.TALK_TO_CUSTOMER

signal update_hold_ui(percentage: float, is_visible: bool)

func send_hold_data(percent: float, visible: bool) -> void:
	update_hold_ui.emit(percent, visible)
