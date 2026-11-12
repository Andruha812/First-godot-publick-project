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
#@export var maxHP: float = 100
#@export var maxMP: float = 80
@onready var in_combat: bool = false
@export var strength: int = 2
@export var stats: PlayerData

signal mpchanged(new_value)
@onready var currentMP: int:
	set(value):
		if value >= stats.maxMP or value <= 0:
			mpchanged.emit(stats.maxMP)
			currentMP = stats.maxMP
		else:
			mpchanged.emit(value)
			currentMP = value

@export var mp: ProgressBar:
	set(node):
		mpchanged.connect(node.set_new_value)
		node.set_status(stats.maxMP, currentMP)
		mana_bar = node

signal healthChanged(new_value)
@onready var currentHP: int:
	set(value):
		if value<currentHP:
			in_combat_timer.start()
			in_combat = true
		if value >= stats.maxHP:
			currentHP = stats.maxHP	
			healthChanged.emit(stats.maxHP)
		elif value <= 0:
			currentHP = 0
			healthChanged.emit(stats.naxHP)
		else:
			currentHP = value	
			healthChanged.emit(value)

@export var hp: ProgressBar:
	set(node):
		healthChanged.connect(node.set_new_value)
		node.set_status(stats.maxHP, currentHP)
		healt_bar = node

func _ready() -> void:
	if healt_bar:
		healt_bar.set_status(stats.maxHP, currentHP)
	if stats: 
		currentHP = stats.maxHP
		currentMP = stats.maxMP

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

	if Input.is_action_just_pressed("skill_F"):
		skill()

	move_and_slide()
	

func _on_down_time_timeout() -> void:
	collision_mask = mask
	
func hp_regenerate():
	if in_combat == false:
		if currentHP < stats.maxHP:
			currentHP += 1
			#currentMP += 1
			print("hp:", currentHP)
			
func mp_regenerate():
	if in_combat == false:
		if currentMP < stats.maxMP:
			#currentHP += 1
			currentMP += 1
			print("mp:", currentMP)
#func hurtByEnemy(area):
	#healthChanged.emit()


func _on_in_combat_timer_timeout() -> void:
	in_combat = false
	


func _on_regen_timer_timeout() -> void:
	hp_regenerate()
	mp_regenerate()
	
func skill() -> void:
	currentMP -= 15
