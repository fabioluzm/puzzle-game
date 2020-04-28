extends KinematicBody2D
class_name Player

# Reference to the AnimatedSprite to be updated as the player move
onready var animated_sprite: AnimatedSprite = $AnimatedSprite


# Player normal speed and pushing boxes speed
export var move_speed: = 250.0
export var push_speed: = 125.0

# Player movement
func _physics_process(delta: float) -> void:
	var motion : = Vector2()
	
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	update_animation(motion)
	move_and_slide(motion.normalized() * move_speed, Vector2())
	
	# check collisions after movement
	if get_slide_count() > 0:
		check_box_collision(motion)

# Player animation when moving
func update_animation(motion: Vector2) -> void:
	var animation : String
	
	if motion.x > 0:
		animation = 'Right'
	elif motion.x < 0:
		animation = 'Left'
	elif motion.y > 0:
		animation = 'Down'
	elif motion.y < 0:
		animation = 'Up'
	else:
		animation = 'Idle'
		
	# force a new anymation to be played if diferent than the one is beeing played
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)

func check_box_collision(motion: Vector2) -> void:
	# check diagonal movement
	if abs(motion.x) + abs(motion.y) > 1:
		return
	
	# check collision with a box
	var box: = get_slide_collision(0).collider as Box
	if box:
		box.push(push_speed * motion)
