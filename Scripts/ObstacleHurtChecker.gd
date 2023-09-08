extends Area2D

func _on_ObstacleHurtChecker_body_entered(body):
	body.get_hurt(global_position, 2)
