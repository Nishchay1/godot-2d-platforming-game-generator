extends "res://Scripts/BaseEnemy.gd"


const SPEED = 60
var velocity = Vector2.ZERO
var player = null

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * SPEED
	velocity = move_and_slide(velocity)

func _on_DetectionZone_body_entered(body):
	if(body.is_in_group("player")):
		player = body


func _on_VisibilityNotifier2D_screen_exited():
	if player != null:
		player = null

func _on_AttackHitCheck_hit():
	destroy()
