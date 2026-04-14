extends CharacterBody2D

#Movement settings
@export var speed := 200
@export var gravity := 900
@export var fly_force := -400

# Nodes
@onready var anim_player = $Visual/AnimationPlayer
@onready var Visual = $Visual

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	# Horizontal movement
	velocity.x = direction * speed
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Flying (hold space)
	if Input.is_action_pressed("fly"):
		velocity.y = fly_force
		play_animation("fly")
	else:
		if direction != 0:
			play_animation("walk")
		else:
			play_animation("idle")
			
	# Flip character using scale
	if velocity.x < 0:
		Visual.scale.x = -1
	elif velocity.x > 0:
		Visual.scale.x = 1
		
	move_and_slide()
	
func play_animation(anim_name: String):
	if anim_player.current_animation != anim_name:
		anim_player.play(anim_name)
	
	
