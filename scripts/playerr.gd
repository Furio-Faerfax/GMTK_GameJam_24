extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0

var velocities_light_to_heavy = [-450, -400, -300, -200]
var velocities = [-200, -300, -400, -450]
var speeds = [200, 300, 200, 100]
var scales = [.5, 1, 2, 3]
var current_scale = 1
var can_scale = false

var start_pos = Vector2()

func _ready() -> void:
	start_pos = position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if position.y > get_viewport().content_scale_size.y:
		position = start_pos
		
	move_and_slide()


	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and can_scale:
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			current_scale = current_scale+1 if current_scale < scales.size()-1 else current_scale
			scale = Vector2(scales[current_scale], scales[current_scale])
			Events.notify("Left Mouse clicked")
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			current_scale = current_scale-1 if current_scale > 0 else current_scale
			scale = Vector2(scales[current_scale], scales[current_scale])
			Events.notify("Right Mouse clicked")
		
		SPEED = speeds[current_scale]
		JUMP_VELOCITY = velocities[current_scale]



func _on_area_2d_mouse_entered() -> void:
	$scale_hover.visible = true
	can_scale = true


func _on_area_2d_mouse_exited() -> void:
	$scale_hover.visible = false
	can_scale = false
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().queue_free()
