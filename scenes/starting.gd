extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instr = $instructions
	instr.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass



func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/bg.tscn")



func _on_instruc_but_pressed() -> void:
	var instr = $instructions
	instr.set_visible(true)
