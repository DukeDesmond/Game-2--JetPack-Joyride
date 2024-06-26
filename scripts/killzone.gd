extends Area2D
signal playerDeath
@onready var timer = $Timer
@onready var player = %Player

func _on_body_entered(body):
	timer.start()
	player.gravity = 1000
	player.collision_shape_2d.queue_free()
	emit_signal("playerDeath")
	
func _on_timer_timeout():
	get_tree().reload_current_scene()
