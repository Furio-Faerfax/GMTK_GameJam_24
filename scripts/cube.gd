extends Node2D

var type = "cube"
var body = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if body != null:
		position.x += body.moving

func _on_rigid_body_2d_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	queue_free()


func _on_interact_body_entered(body: Node2D) -> void:
	self.body = body


func _on_interact_body_exited(body: Node2D) -> void:
	self.body = null
