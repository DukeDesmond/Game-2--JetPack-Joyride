extends CharacterBody2D

@export var SPEED = 300
@onready var timer = $Timer

var dir: float
var spawnPos: Vector2
var spawnRot: float

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	timer.start(0.8)
	
func _physics_process(delta):
	velocity = Vector2(0,SPEED).rotated(dir)
	move_and_slide()


func _on_timer_timeout():
	queue_free()
