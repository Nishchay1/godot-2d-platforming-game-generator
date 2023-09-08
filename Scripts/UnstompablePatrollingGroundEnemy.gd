extends "res://Scripts/BaseEnemy.gd"

const GRAVITY = 13
var speed = 60

var velocity = Vector2.ZERO
var terminal_vertical_speed = 300
var direction = 1

onready var right_ground_check = $RightGroundCheck
onready var left_ground_check = $LeftGroundCheck


func _physics_process(delta):
	velocity.y+=GRAVITY
	if velocity.y > terminal_vertical_speed: 
		velocity.y = terminal_vertical_speed

	velocity.x = speed*direction

	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		direction *= -1
	if not left_ground_check.is_colliding():
		direction = 1
	elif not right_ground_check.is_colliding():
		direction = -1


func _on_AttackHitCheck_hit():
	destroy()

