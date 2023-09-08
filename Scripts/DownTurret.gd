extends StaticBody2D

onready var projectile = preload("res://Scenes/VerticalProjectile.tscn")
onready var projectile_origin = $ProjectileOrigin
onready var shoot_timer = $ShootTimer

func shoot():
	var p = projectile.instance()
	p.set_direction(1)
	get_tree().current_scene.add_child(p)
	p.transform = projectile_origin.global_transform


func _on_ShootTimer_timeout():
	shoot()


func _on_VisibilityNotifier2D_screen_entered():
	shoot_timer.start()


func _on_VisibilityNotifier2D_screen_exited():
	shoot_timer.stop()
