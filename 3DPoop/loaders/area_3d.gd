extends Area3D


func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().get_parent().get_parent() is Node3D:
		Clawping.player.on_fl = true
		


func _on_area_exited(area: Area3D) -> void:
	if area.get_parent().get_parent().get_parent() is Node3D:
		Clawping.player.on_fl = false
