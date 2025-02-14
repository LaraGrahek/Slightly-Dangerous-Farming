extends Node2D

var turns = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var wheel = get_node("wheel")
	var dice = get_node("dice")
	var instr = get_node("instructions")
	var endscr = $end
	endscr.set_visible(false)
	endscr.set_done(3)
	instr.set_visible(false)
	dice.set_visible(true)
	wheel.set_visible(false)
	wheel.set_in_progress(false)
	edit_text("0", "points")
	edit_text("0", "pig")
	edit_text("0", "cow")
	edit_text("0", "chicken")
	edit_text("0", "carrot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var wheel = get_node("wheel")
	var dice = get_node("dice")
	var but = get_node("instrucBut")
	var instr = get_node("instructions")
	if (instr.get_use() == false):
		but.set_visible(true)
	else:
		but.set_visible(false)
	#the user has turns to do
	if (turns > 0):
		#die goes invisible
		if (!dice.is_visible()): 
			#wheel isn't in use
			if (!wheel.get_in_progress()): 
				wheel.spins(dice.get_num()) #gets the number that was rolled on the die, and sends it to the wheel
				wheel.set_visible(true) #wheel is visible
				wheel.set_in_progress(true) #wheel is in progress
				wheel.set_spins_left(true) #player has wheel spins to do
			#wheel is in use
			else: 
				if (wheel.get_spins_left()): #player still has spins left on the wheel (turn isn't yet over)
					#updates all the numbers on the left
					edit_text(wheel.get_points(), "points")
					edit_text(wheel.get_pigs(), "pig")
					edit_text(wheel.get_cows(), "cow")
					edit_text(wheel.get_chickens(), "chicken")
					edit_text(wheel.get_carrots(), "carrot")
				else: #the turn is over
					dice.dice_reset() #resets the die
					wheel.set_in_progress(false) #wheel is not in progress
					wheel.set_spins_left(false) #no spins left
					turns -= 1 #subtracts a turn
	else:
		var endscr = $end
		endscr.send_points(wheel.get_points())
		endscr.set_visible(true)
		if (endscr.get_done() == 3):
			edit_text("0", "points")
			edit_text("0", "pig")
			edit_text("0", "cow")
			edit_text("0", "chicken")
			edit_text("0", "carrot")
			print ("f")
			dice.dice_reset()
			wheel.wheel_reset()
			turns = endscr.get_done()
			endscr.set_done(0)

func edit_text(text, nam) -> void:
	var textBox = get_node(nam)
	textBox.clear()
	textBox.add_text(str(text))
	
func _on_instruc_but_pressed() -> void:
	var instr = $instructions
	instr.set_use(true)
	instr.set_visible(true)
