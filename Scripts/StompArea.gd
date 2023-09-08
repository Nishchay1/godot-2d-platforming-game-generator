extends Area2D

signal stomped


func send_stomped():
	emit_signal("stomped")
	return 1
