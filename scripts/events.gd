extends Node

var notifiying_text = ""
signal notify_me()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func notify(val):
	Events.notifiying_text = val
	Events.notify_me.emit()
