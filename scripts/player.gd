extends CharacterBody2D

signal took_damage

var speed = 300

var rocket_scene = preload("res://scenes/rocket.tscn")

@onready var rocket_container = $RocketContainer # get_node("RocketContainer")

@onready var rocket_shot_sound = $RocketShotSound

# _process function
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

# Handle ship physics movement
func _physics_process(delta: float) -> void:
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed('move_right'):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
		
	# Using Godot clamp() function on the global position vector 
	global_position = global_position.clamp(Vector2(0, 0), screen_size)
		
# Shoot a rocket from the ship
func shoot() -> void:
	var rocket_instance = rocket_scene.instantiate()
	
	# Set the initial position of the rocket to the player global position
	# Then, increase position in x to launch the rocket in front of th ship
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	
	rocket_container.add_child(rocket_instance)
	
	# Play rocket shot sound during instantiation
	rocket_shot_sound.play()
	
func take_damage() -> void:
	emit_signal("took_damage")

func die() -> void:
	queue_free()
