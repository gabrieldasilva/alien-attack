extends Area2D

@export var speed = 120

@onready var visible_notifier = $VisibleNotifier

func _ready() -> void:
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta: float) -> void:
	# Move rocket by increasing global_position on x's axis by speed
	
	# By multiplying the rocket speed by the delta, we can think on the amount of
	# pixel the rocket will move per second instead of the amount of pixels the 
	# rocket will move by frame. This avoids the hardware dependency for FPS.
	global_position.x += speed * delta

func _on_screen_exited() -> void:
	# Remove the rocket when it goes out of the screen
	queue_free()

func _on_area_entered(enemy: Area2D) -> void:
	# Remove the rocket
	queue_free()
	
	# Call die function on the enemy
	enemy.die()
