extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
const Dash_Velocity = 1000
var dash = false
var dash_variable = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("spacebar-move") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Dashing controll
	if Input.is_action_just_pressed("ctr-action") :
		if dash_variable == true:
			dash = true
			dash_variable = false
			$Dashing.start()
			$Dash_Timer.start()
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a-move", "d-move")
	if direction:
		if dash == true:
			velocity.x = direction * Dash_Velocity
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#dash timer
func _on_dashing_timeout() -> void:
	dash = false


func _on_dash_timer_timeout() -> void:
	dash_variable = true
