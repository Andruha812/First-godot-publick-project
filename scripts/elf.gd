extends CharacterBody2D

class_name Player

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var layer = collision_layer
@onready var mask = collision_mask
@onready var healt_bar: ProgressBar = $healtBar
@onready var mana_bar: ProgressBar = $Mana_bar
@onready var down_timer : Timer = $down_timer
@onready var in_combat_timer: Timer = $in_combat_timer
@export var maxHP: float = 100
@export var maxMP: float = 80
@onready var in_combat: bool = false
@export var strenght: int = 2

signal mpchanged(new_value)
@export var currentMP: int = maxMP:
	set(value):
		if value >= maxMP or value <= 0:
			mpchanged.emit(maxMP)
			currentMP = maxMP
		else:
			mpchanged.emit(value)
			currentMP = value

@export var mp: ProgressBar:
	set(node):
		mpchanged.connect(node.set_new_value)
		node.set_status(maxMP, currentMP)
		mana_bar = node

signal healthChanged(new_value)
@export var currentHP: int = maxHP:
	set(value):
		if value<currentHP:
			in_combat_timer.start()
			in_combat = true
		if value >= maxHP or value <= 0:
			healthChanged.emit(maxHP)
			currentHP = maxHP	
		else:
			healthChanged.emit(value)
			currentHP = value	

@export var hp: ProgressBar:
	set(node):
		healthChanged.connect(node.set_new_value)
		node.set_status(maxHP, currentHP)
		healt_bar = node
		
func _ready() -> void:
	if healt_bar:
		healt_bar.set_status(maxHP, currentHP)
	

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
	
func passive_regenerate():
	if in_combat == false && currentHP != maxHP:
		currentHP += 1
		#currentMP += 1
		print("hp:", currentHP)
		#await get_tree().create_timer(1).timeout
#func hurtByEnemy(area):
	#healthChanged.emit()


func _on_in_combat_timer_timeout() -> void:
	in_combat = false


func _on_regen_timer_timeout() -> void:
	passive_regenerate()
	
