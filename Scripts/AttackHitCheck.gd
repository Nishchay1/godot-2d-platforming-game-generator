extends Area2D


signal hit


func _on_AttackHitCheck_area_entered(area):
	emit_signal("hit")
