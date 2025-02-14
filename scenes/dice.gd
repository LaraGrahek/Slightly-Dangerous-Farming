extends Node2D

var R = RandomNumberGenerator.new()
var num = R.randi_range(1,4)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var diceAnim = get_node("diceAnim")
	diceAnim.set_frame(0)
	edit_text("roll the die !")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var diceAnim = get_node("diceAnim")
	var button = $Button
	button.set_visible(false)
	diceAnim.play()
	await get_tree().create_timer(2).timeout
	diceAnim.pause()
	if (num == 1):
		diceAnim.set_frame(0)
		edit_text("you rolled a 1 !")
		hide_dice()
	elif (num == 2):
		diceAnim.set_frame(6)
		edit_text("you rolled a 2 !")
		hide_dice()
	elif (num == 3):
		diceAnim.set_frame(9)
		edit_text("you rolled a 3 !")
		hide_dice()
	else:
		diceAnim.set_frame(3)
		edit_text("you rolled a 4 !")
		hide_dice()
		
func hide_dice() -> void:
	await get_tree().create_timer(2).timeout
	set_visible(false)

func edit_text(text) -> void:
	var diceText = get_node("diceText")
	diceText.clear()
	diceText.add_text(text)

func dice_reset() -> void:
	set_visible(true)
	num = R.randi_range(1,4)
	var button = $Button
	button.set_visible(true)
	edit_text("roll the die !")

func get_num() -> int:
	return num
