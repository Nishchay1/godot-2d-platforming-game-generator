extends "res://Scripts/BaseEnemy.gd"


const SPEED = 90

var velocity = Vector2.ZERO
var terminal_vertical_speed = 300
var direction = 1
var jump_height = 32
var friction = 0.25
var jump_peak_time = 0.4

var can_jump = false
var directions = [-1,1]

onready var gravity = (2*jump_height)/(pow(jump_peak_time,2))
onready var jump_velocity = gravity*jump_peak_time
onready var jump_timer = $JumpTimer

func _physics_process(delta):
	velocity.y+=gravity*delta
	if velocity.y > terminal_vertical_speed:
		velocity.y = terminal_vertical_speed
	
	if is_on_floor():
		can_jump=true
		apply_friction()
	else:
		can_jump=false

	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		direction *= -1


func jump():
	if can_jump:
		velocity.y = -jump_velocity
		randomize()
		velocity.x = SPEED*directions[randi() % directions.size()]

func apply_friction():
	velocity.x = lerp(velocity.x, 0, friction)


func _on_JumpTimer_timeout():
	jump()
	jump_timer.start()

func _on_StompChecker_kill():
	destroy()
