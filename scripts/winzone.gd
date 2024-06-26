extends Area2D

@onready var label = %Label
@onready var timer = $Timer


func _on_body_entered(body):
	label.text = "You Won!"
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/winMenu.tscn")
