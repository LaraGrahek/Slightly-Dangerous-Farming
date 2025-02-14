extends Node2D

var use = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	var instr = $instr
	if (instr.get_frame() < 2):
		instr.set_frame(instr.get_frame()+1)
	else:
		instr.set_frame(0)


func _on_exit_pressed() -> void:
	use = false
	set_visible(false)

func set_use(b) -> void:
	use = b
	
func get_use() -> bool:
	return use
