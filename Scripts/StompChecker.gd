extends Area2D

signal kill

func send_stomped():
	return 0



func _on_StompChecker_area_entered(area):
	var check = area.send_stomped()
	if check==1:
		emit_signal("kill")
