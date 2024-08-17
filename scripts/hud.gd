extends Control
@onready var s_potion: Control = $elements/s_potion
@onready var g_potion: Control = $elements/g_potion
@onready var bomb: Control = $elements/bomb

enum HUD_ELEMENTS{
	SHRINK,
	GROW,
	BOMB
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func alter_slot(slot, val):
	match slot:
		HUD_ELEMENTS.SHRINK: s_potion.get_node("amount").text = str(val)
		HUD_ELEMENTS.GROW: g_potion.get_node("amount").text = str(val)
		HUD_ELEMENTS.BOMB: bomb.get_node("amount").text = str(val)
		_: pass
