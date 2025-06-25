extends CharacterBody2D

var speed = 300

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
	
	# Clamp the player movement
	
	# Using individual if statements (the manual / hard work)
	#if global_position.x < 0:
		#global_position.x = 0
	#if global_position.x > screen_size.x:
		#global_position.x = screen_size.x
	#if global_position.y < 0:
		#global_position.y = 0
	#if global_position.y > screen_size.y:
		#global_position.y = screen_size.y
		
	# Using global purpose clamp() function on each axis of global_position 
	#global_position.x = clamp(global_position.x, 0, screen_size.x)
	#global_position.y = clamp(global_position.y, 0, screen_size.y)
	
	# Using Godot clamp() function on the global position vector 
	global_position = global_position.clamp(Vector2(0, 0), screen_size)
