extends CharacterBody2D

class_name Player

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var layer = collision_layer
@onready var mask = collision_mask
@onready var healt_bar: ProgressBar = $healtBar
@onready var down_timer : Timer = $down_timer
@onready var maxHP: int = 100

signal healthChanged(new_value)
@onready var currentHP: int = maxHP:
	set(value):
		healthChanged.emit(value)
		currentHP = value


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left_move", "right_move")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("down_move") and is_on_floor():
		collision_mask = 1
		down_timer.start()


	move_and_slide()


func _on_down_time_timeout() -> void:
	collision_mask = mask
	
#func hurtByEnemy(area):
	#healthChanged.emit()
