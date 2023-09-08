extends Area2D

func destroy():
	queue_free()

func _on_HealthPickUp_body_entered(body):
	body.increase_health()
	destroy()
