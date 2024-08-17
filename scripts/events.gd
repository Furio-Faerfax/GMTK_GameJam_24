extends Node

var notifiying_text = ""
signal notify_me()
var maximized = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("maximize"):
		maximized = !maximized
		if maximized:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _ready() -> void:
	if maximized:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	
func notify(val):
	Events.notifiying_text = val
	Events.notify_me.emit()
