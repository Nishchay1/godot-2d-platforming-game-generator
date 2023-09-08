extends "res://Scripts/BaseStompableSlashableEnemy.gd"

const SPEED = 90

var velocity = Vector2.ZERO
var terminal_vertical_speed = 300
var direction = 1

var jump_height = 64

var jump_peak_time = 0.4

var can_jump = false

onready var gravity = (2*jump_height)/(pow(jump_peak_time,2))
onready var jump_velocity = gravity*jump_peak_time
onready var detection_box = $DetectionZone


func _physics_process(delta):
	velocity.y+=gravity*delta
	if velocity.y > terminal_vertical_speed:
		velocity.y = terminal_vertical_speed

	velocity.x = SPEED*direction
	
	if is_on_floor():
		can_jump=true
	else:
		can_jump=false

	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		direction *= -1


func _on_HurtChecker_body_entered(body):
	if body.is_in_group("player"):
		if !can_jump:
			direction*=-1


func jump():
	if can_jump:
		velocity.y = -jump_velocity

func _on_DetectionZone_body_entered(body):
	if body.is_in_group("player"):
		jump()

