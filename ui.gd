extends Control

# Called when the node enters the scene tree for the first time.
const INPUT_NOTIFIER = preload("res://scenes/ui/input_notifier.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.notify_me.connect(_spawn_input_notes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _spawn_input_notes():
	var instance = INPUT_NOTIFIER.instantiate()
	self.add_child(instance)
	instance.position = Vector2(10,50)
	instance.get_node("input").text = Events.notifiying_text
