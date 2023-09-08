extends Area2D


func _on_EnemyHurtChecker_body_entered(body):
	body.get_hurt(global_position, 1)
