extends CharacterBody2D

@onready var hud: Control = $"../ui/hud"

var SPEED = 300.0
var JUMP_VELOCITY = -400.0

var velocities_light_to_heavy = [-450, -400, -300, -200]
var velocities = [-200, -300, -400, -450]
var speeds = [400, 300, 200, 100]
var scales = [.5, 1, 2, 3]
var current_scale = 1
var can_scale = false

var shrink_potion = 9
var grow_potion = 9
var bombs = 0

var can_grow = true
var can_shrink = true
var moving = true

var start_pos = Vector2()

func _ready() -> void:
	start_pos = position
	
	hud.alter_slot(hud.HUD_ELEMENTS.GROW, grow_potion)
	hud.alter_slot(hud.HUD_ELEMENTS.SHRINK, shrink_potion)
	hud.alter_slot(hud.HUD_ELEMENTS.BOMB, bombs)

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
	moving = direction
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
			scaling(1, "Left Mouse Button")
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			scaling(-1, "Right Mouse Button")
		
	if event is InputEventKey:
		if Input.is_action_just_pressed("first"):
			if shrink_potion > 0 and can_shrink:
				shrink_potion  -= 1
				scaling(-1, "Shrinked by potion")
				hud.alter_slot(hud.HUD_ELEMENTS.SHRINK, shrink_potion)
				
		if Input.is_action_just_pressed("second"):
			if grow_potion > 0 and can_grow:
				grow_potion  -= 1
				scaling(1, "Growed by potion")
				hud.alter_slot(hud.HUD_ELEMENTS.GROW, grow_potion)
				
		if Input.is_action_just_pressed("third"):
			if bombs > 0:
				bombs  -= 1
				hud.alter_slot(hud.HUD_ELEMENTS.BOMB, bombs)



func _on_area_2d_mouse_entered() -> void:
	$scale_hover.visible = true
	can_scale = true


func _on_area_2d_mouse_exited() -> void:
	$scale_hover.visible = false
	can_scale = false
	
func scaling(sign, message):
	if sign >= 1:
		current_scale = current_scale+1 if current_scale < scales.size()-1 else current_scale
	else:
		current_scale = current_scale-1 if current_scale > 0 else current_scale
	
	Events.notify(message)
	scale = Vector2(scales[current_scale], scales[current_scale])
	if current_scale > 0 and !can_shrink:
		can_shrink = true
	elif current_scale == 0 and can_shrink:
		can_shrink = false
		
	if current_scale < scales.size()-1 and !can_grow:
		can_grow = true
	elif current_scale == scales.size()-1 and can_grow:
		can_grow = false
	
	SPEED = speeds[current_scale]
	JUMP_VELOCITY = velocities[current_scale]
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	pass


func _on_interaction_area_area_entered(area: Area2D) -> void:
	var other = area.get_parent()
	var item = other.get_parent()
	var type = other.type
	print(type)
	match type:
		"potion":
			if item.shrink:
				shrink_potion += 1
				#scaling(-1, "Shrink Potion")
				hud.alter_slot(hud.HUD_ELEMENTS.SHRINK, shrink_potion)
				item.queue_free()
			else:
				#scaling(1, "Grow Potion")
				grow_potion += 1
				hud.alter_slot(hud.HUD_ELEMENTS.GROW, grow_potion)
				item.queue_free()
		"bomb":
			bombs += 1
			hud.alter_slot(hud.HUD_ELEMENTS.BOMB, bombs)
			item.queue_free()
		_: pass
