extends Control

@export_group("Buttons")
@export var button1: Button
@export var button2: Button
@export var button3: Button
@export var button4: Button
@export var button5: Button

@export_group("Result Images")
@export var image1: CanvasItem
@export var image2: CanvasItem
@export var image3: CanvasItem
@export var image4: CanvasItem
@export var image5: CanvasItem

func _ready() -> void:
	_hide_all_images()
	
	button1.pressed.connect(_on_emotion_selected.bind(image1))
	button2.pressed.connect(_on_emotion_selected.bind(image2))
	button3.pressed.connect(_on_emotion_selected.bind(image3))
	button4.pressed.connect(_on_emotion_selected.bind(image4))
	button5.pressed.connect(_on_emotion_selected.bind(image5))
	

func _on_emotion_selected(selected_image: CanvasItem) -> void:
	_hide_all_images()
	
	if selected_image:
		selected_image.show()
		print("Emotion selected!")

func _hide_all_images() -> void:
	if image1: image1.hide()
	if image2: image2.hide()
	if image3: image3.hide()
	if image4: image4.hide()
	if image5: image5.hide()
