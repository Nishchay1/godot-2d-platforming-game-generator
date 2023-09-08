extends "res://Scripts/BaseEnemy.gd"

func _on_StompChecker_kill():
	destroy()

func _on_AttackHitCheck_hit():
	destroy()

func send_stomped():
	return 0
