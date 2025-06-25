extends Area2D

@export var speed = 120

func _physics_process(delta: float) -> void:
	# Move rocket by increasing global_position on x's axis by speed
	
	# By multiplying the rocket speed by the delta, we can think on the amount of
	# pixel the rocket will move per second instead of the amount of pixels the 
	# rocket will move by frame. This avoids the hardware dependency for FPS.
	global_position.x += speed * delta
