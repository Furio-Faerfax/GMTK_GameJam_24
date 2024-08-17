extends Node2D

var type = "potion"

@export var shrink = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !shrink:
		$potion_sprite.texture = load("res://assets/grow_potion.png") #just for now

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
