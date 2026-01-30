extends Node
var is_dialogue_active: bool = false

enum CookingStep { TALK_TO_CUSTOMER, RICE_COOKER, STOVE, START_MINIGAME }
var current_step: CookingStep = CookingStep.TALK_TO_CUSTOMER
