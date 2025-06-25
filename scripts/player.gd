extends CharacterBody2D

var speed = 300

var rocket_scene = preload("res://scenes/rocket.tscn")

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
	rocket_instance.global_position.x += 80
	add_child(rocket_instance)
