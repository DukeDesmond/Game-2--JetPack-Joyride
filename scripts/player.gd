extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -80.0
var life = true
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var game = get_tree().get_root().get_node("Game")
@onready var projectile = load("res://scenes/bullet.tscn")
@onready var timer = $Timer


var reload : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 90

func _ready():
	life = true
	
func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	game.add_child.call_deferred(instance)

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and life == true:
		velocity.y = JUMP_VELOCITY
		if reload == false:
			shoot()
			reload = true
			timer.start(0.1)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0 and life == true:
		animated_sprite_2d.flip_h = true
	elif direction < 0 and life == true:
		animated_sprite_2d.flip_h = false
	
	if direction and life == true:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()



func _on_killzone_player_death():
	life = false


func _on_timer_timeout():
	reload = false;
