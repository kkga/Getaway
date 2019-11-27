extends RigidBody

var has_finished_spawning = false


func _on_Timer_timeout() -> void:
	queue_free()

func _on__body_entered(body: Node) -> void:
	if not $AudioStreamPlayer3D.playing:
		$AudioStreamPlayer3D.play()


func _on__sleeping_state_changed() -> void:
	if not sleeping and has_finished_spawning:
		$Timer.start()
	else:
		has_finished_spawning = true
