extends CharacterBody2D
const SPEED = 130.0
@onready var animated_sprite = $AnimatedSprite2D

#Calculates angle between character and cursor
func get_angle():
	var mouse_position = get_global_mouse_position()
	var angle_radians = self.get_angle_to(mouse_position)
	var angle_degrees = rad_to_deg(angle_radians)
	return angle_degrees

#Faces character depending on angle to the cursor
func face_character(angle):
	if angle >-30 && angle < 30:
		animated_sprite.play("Idle_Side")
		animated_sprite.flip_h = false
		
	elif angle > 30 && angle < 150:
		animated_sprite.play("Idle_Front")	
	
	elif angle < -30 && angle > -150:
		animated_sprite.play("Idle_Back")
	else:
		animated_sprite.play("Idle_Side")
		animated_sprite.flip_h = true

#Gets keyboard input for directional input
func get_direction():
	var direction := Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = direction * SPEED

#Plays attack animation depending on angle to the cursor TODO:Timer on animation
func on_attack(angle):
	var attack := Input.is_action_just_pressed("attack")
	if attack:
		if angle > -30 && angle < 30:
			animated_sprite.play("Attack_Side")
			animated_sprite.flip_h = false
		
		elif angle > 30 && angle < 150:
			animated_sprite.play("Attack_Front")	
	
		elif angle < -30 && angle > -150:
			animated_sprite.play("Idle_Back")
		else:
			animated_sprite.play("Attack_Side")
			animated_sprite.flip_h = true

func _physics_process(_delta: float) -> void:	
	get_direction()
	var angle = get_angle()
	face_character(angle)
	on_attack(angle)
	move_and_slide()
