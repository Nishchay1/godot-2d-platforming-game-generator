extends Area2D

var velocity = Vector2.ZERO
var direction = 1
const SPEED = 200
var hurt_damage = 1

func _ready():
	velocity.x = SPEED * direction

func _physics_process(delta):
	position.y+=SPEED*direction*delta
#	if collision != null:
#		print(collision)
#		destroy()

func set_direction(value):
	direction = value

func destroy():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_VerticalProjectile_body_entered(body):
	if body.is_in_group("player"):
		body.get_hurt(position, hurt_damage)
	destroy()
