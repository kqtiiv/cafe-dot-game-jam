extends PathFollow3D

@export var speed: float = 2.0

func _physics_process(delta):
	progress += speed * delta
