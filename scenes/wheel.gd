extends Node2D

# generates a random integer
var R = RandomNumberGenerator.new()
var num: int = R.randi_range(0,19) #for the wheel
var randNum: int = R.randi_range(1,20) #for the cards
var frame = 21 #placeholder for the current frame number
var spin_num: int
var spins_left: bool
var in_progress: bool
var points = 0
var pigs = 0
var cows = 0
var chicken = 0
var carrot = 0
var tospin = false
var t = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cards = get_node("cardAnim")
	cards.set_visible(false) #makes the cards invisible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	wheel()
	
	
#called when the "spin" button is pressed
func _on_button_pressed() -> void:
	var wheelAnim = get_node("wheelAnim")
	var button = $Button
	button.set_visible(false)
	wheelAnim.play()

func wheel() -> void:
	var wheelAnim = get_node("wheelAnim")
	if (spin_num == 0): #the player has used up all thier wheel spins
		spins_left = false
		set_visible(false)
	edit_text("spin the wheel !", "wheelAnim/wheelText")
	edit_text(str(spin_num), "wheelAnim/spinsText")
	frame = wheelAnim.get_frame() #gets current frame
	if (wheelAnim.is_playing()): 
		await get_tree().create_timer(2*t).timeout #waits 2 seconds
		if (frame == num): #the frame correlates with the random number
			wheelAnim.pause()
			#text changes depending on which part of the wheel is landed on
			if (num == 0 or num == 3 or num == 4 or num == 7 or num == 8 or num == 9 or num == 12 or num == 15 or num == 16):
				edit_text("you landed on deck 1 !", "wheelAnim/wheelText")
			elif (num == 2 or num == 5 or num == 10 or num == 11 or num == 17 or num == 18 or num == 19):
				edit_text("you landed on deck 2 !", "wheelAnim/wheelText")
			else:
				edit_text("you landed on deck 3 !", "wheelAnim/wheelText")
			await get_tree().create_timer(1*t).timeout
			hide_wheel() #hides the wheel, button, and text

#hides the wheel, button, and text
func hide_wheel() -> void:
	var wheelAnim = get_node("wheelAnim")
	var button = get_node("Button")
	await get_tree().create_timer(1*t).timeout
	wheelAnim.set_visible(false)
	button.set_visible(false)
	edit_text(" ", "wheelAnim/wheelText")
	decks()

#edits the text to which ever text box is inputted
func edit_text(text, nam) -> void:
	var textBox = get_node(nam)
	textBox.clear()
	textBox.add_text(text)

#retrieves the number rolled on the die and assigns it to the variable spin_num
func spins(n) -> void:
	spin_num = n

#player chooses a card from one of 3 decks
func decks() -> void:
	var cards = get_node("cardAnim")
	#buttons to choose from deck 1, 2, and 3
	var but1 = get_node("cardAnim/deck1") 
	var but2 = get_node("cardAnim/deck2")
	var but3 = get_node("cardAnim/deck3")
	var deats = $cardAnim/deaths
	var spinBut = $cardAnim/deathBut
	var coin = $cardAnim/coin
	var coinBut = $cardAnim/coinBut
	edit_text("pick a card !", "cardAnim/cardText")
	cards.set_visible(true)
	deats.set_visible(false)
	spinBut.set_visible(false)
	coin.set_visible(false)
	coinBut.set_visible(false)
	if (num == 0 or num == 3 or num == 4 or num == 7 or num == 8 or num == 9 or num == 12 or num == 15 or num == 16): #deck 1 is landed on from the wheel
		but1.set_visible(true) #only the button to choose from deck 1 is available
		but2.set_visible(false)
		but3.set_visible(false)
		num = -1
	elif (num == 2 or num == 5 or num == 10 or num == 11 or num == 17 or num == 18 or num == 19): #deck 2
		but1.set_visible(false)
		but2.set_visible(true) #only the button to choose from deck 2 is available
		but3.set_visible(false)
		num = -1
	elif (num ==1 or num == 6 or num == 13 or num == 14): #deck 3
		but1.set_visible(false)
		but2.set_visible(false)
		but3.set_visible(true) #only the button to choose from deck 3  is available
		num = -1
	else:
		pass

#called when the button for deck 1 is pressed
func _on_deck_1_pressed() -> void:
	var cards = $cardAnim
	var button1 = $cardAnim/deck1
	button1.set_visible(false)
	print("false?")
	#generates a random integer from 1-20
	randNum = R.randi_range(1,20)
	if (randNum == 1):
		cards.set_frame(1)
		points += 20
		pigs += 1
		card_choose("pig", "+20")
	elif (randNum == 2 or randNum == 3):
		cards.set_frame(2)
		points += 10
		cows += 1
		card_choose("cow", "+10")
	elif (randNum == 4 or randNum == 5 or randNum == 6 or randNum == 7):
		cards.set_frame(3)
		points += 5
		chicken += 1
		card_choose("chicken", "+5")
	elif (randNum == 8 or randNum == 9 or randNum == 10):
		cards.set_frame(4)
		points += 3
		carrot += 1
		card_choose("carrot", "+3")
	elif (randNum == 11 or randNum == 12 or randNum == 13 or randNum == 14):
		cards.set_frame(5)
		wolf_card()
	elif (randNum == 15 or randNum == 16 or randNum == 17 or randNum == 18):
		cards.set_frame(6)
		points -= 15
		card_choose("disease", "-15")
	else:
		cards.set_frame(7)
		dragon_card()

func _on_deck_2_pressed() -> void:
	var cards = $cardAnim
	var button2 = $cardAnim/deck2
	button2.set_visible(false)
	print ("false?")
	#generates a random integer from 1-20
	randNum = R.randi_range(1,20)
	if (randNum == 1 or randNum ==2):
		cards.set_frame(1)
		pigs += 1
		points += 20
		card_choose("pig", "+20")
	elif (randNum == 4 or randNum == 3):
		cards.set_frame(2)
		points += 10
		cows += 1
		card_choose("cow", "+10")
	elif (randNum == 8 or randNum == 5 or randNum == 6 or randNum == 7 or randNum == 9):
		cards.set_frame(3)
		points += 5
		chicken += 1
		card_choose("chicken", "+5")
	elif (randNum == 11 or randNum == 12 or randNum == 10):
		cards.set_frame(4)
		points += 3
		carrot += 1
		card_choose("carrot", "+3")
	elif (randNum == 15 or randNum == 16 or randNum == 13 or randNum == 14):
		cards.set_frame(5)
		wolf_card()
	elif (randNum == 19 or randNum == 17 or randNum == 18):
		cards.set_frame(6)
		points -= 15
		card_choose("disease", "-15")
	else:
		cards.set_frame(7)
		dragon_card()

func _on_deck_3_pressed() -> void:
	var cards = $cardAnim
	var button3 = $cardAnim/deck3
	button3.set_visible(false)
	print("p")
	#generates a random integer from 1-20
	randNum = R.randi_range(1,20)
	if (randNum == 1 or randNum == 2 or randNum == 3):
		cards.set_frame(1)
		points += 20
		pigs += 1
		card_choose("pig", "+20")
	elif (randNum == 4 or randNum == 5):
		cards.set_frame(2)
		points += 10
		cows += 1
		card_choose("cow", "+10")
	elif (randNum == 8 or randNum == 10 or randNum == 6 or randNum == 7 or randNum == 9):
		cards.set_frame(3)
		points += 5
		chicken += 1
		card_choose("chicken", "+5")
	elif (randNum == 11 or randNum == 12 or randNum == 13 or randNum == 14 or randNum == 15):
		cards.set_frame(4)
		points += 3
		carrot += 1
		card_choose("carrot", "+3")
	elif (randNum == 16 or randNum == 17 or randNum == 18):
		cards.set_frame(5)
		wolf_card()
	else:
		cards.set_frame(6)
		points -= 15
		card_choose("disease", "-15")

func card_choose(card, points) -> void:
	var but1 = $cardAnim/deck2
	but1.set_visible(false)
	var but2 = $cardAnim/deck2
	but2.set_visible(false)
	var but3 = $cardAnim/deck2
	but3.set_visible(false)
	var cards = get_node("cardAnim")
	edit_text("you got a " + card + " !", "cardAnim/cardText")
	await get_tree().create_timer(1.5*t).timeout
	edit_text(points + " points", "cardAnim/cardText")
	await get_tree().create_timer(2*t).timeout
	cards.set_visible(false) #makes the cards invisible
	var wheelAnim = get_node("wheelAnim")
	var button = get_node("Button")
	wheelAnim.set_visible(true) #makes wheel visible
	button.set_visible(true)
	num = R.randi_range(0,19)
	spin_num -= 1 #subtracts the number of spins left by 1
	cards.set_frame(0)
	wheel()
	
func dragon_card() ->  void:
	var deats = $cardAnim/deaths
	var spinBut = $cardAnim/deathBut
	var text = $cardAnim/cardText
	text.push_font_size(2)
	edit_text("you got a dragon !", "cardAnim/cardText")
	await get_tree().create_timer(1.5*t).timeout
	edit_text("-30 points", "cardAnim/cardText")
	points -= 30
	await get_tree().create_timer(1*t).timeout
	edit_text("oh no ! the dragon wants to kill your animals !", "cardAnim/cardText")
	deats.set_visible(true)
	spinBut.set_visible(true)
	await get_tree().create_timer(1*t).timeout
	edit_text("spin the wheel to find out how many will die .", "cardAnim/cardText")
	frame = deats.get_frame() #gets current frame
 
		

func wolf_card() -> void:
	var deats = $cardAnim/deaths
	var spinBut = $cardAnim/deathBut
	var text = $cardAnim/cardText
	edit_text("you got a wolf !", "cardAnim/cardText")
	await get_tree().create_timer(1.5*t).timeout
	edit_text("-9 points", "cardAnim/cardText")
	points -= 9
	await get_tree().create_timer(2*t).timeout
	text.push_font_size(1)
	edit_text("the wolf wants to brutally murder your animals !", "cardAnim/cardText")
	await get_tree().create_timer(2*t).timeout
	print("should be visible")
	deats.set_visible(true)
	spinBut.set_visible(true)
	edit_text("spin the wheel to find out how many will die .", "cardAnim/cardText")

func deaths(all) -> int:
	var minus = 0
	var counter = (pigs+cows+chicken+carrot)
	if (all == 6 or all == 7 or all == 8):
		edit_text("half of your animals died !", "cardAnim/cardText")
		while (counter/2 > 0):
			var dNum = R.randi_range(1, 4)
			if (pigs > 0 and dNum == 1):
				pigs -=1
				points -= 20
				minus += 20
			elif (cows > 0 and dNum == 2):
				cows -=1
				points -= 10
				minus += 10
			elif (chicken > 0 and dNum ==3):
				chicken -= 1
				points -=5
				minus += 5
			else:
				carrot -= 1
				points -=3	
				minus += 3
			counter -= 1
		await get_tree().create_timer(1.5*t).timeout
		edit_text("-" + str(minus) + " points !", "cardAnim/cardText")
		return minus
	else:
		edit_text("all of your animals died !", "cardAnim/cardText")
		while (counter > 0):
			var dNum = R.randi_range(1, 4)
			if (pigs > 0 and dNum == 1):
				pigs -=1
				points -= 20
				minus += 20
			elif (cows > 0 and dNum == 2):
				cows -=1
				points -= 10
				minus += 10
			elif (chicken > 0 and dNum ==3):
				chicken -= 1
				points -=5
				minus += 5
			else:
				carrot -= 1
				points -=3	
				minus += 3
			counter -= 1
		await get_tree().create_timer(1.5*t).timeout
		edit_text("- " + str(minus) + "points !", "cardAnim/cardText")
		return minus
		
func _on_death_but_pressed() -> void:
	var cards = $cardAnim
	var deats = $cardAnim/deaths
	var rNum = R.randf_range((12/9),(3*12/9)) 
	var deatsBut = $cardAnim/deathBut
	var pframe = -1
	deatsBut.set_visible(false)
	deats.play()
	await get_tree().create_timer(rNum).timeout #waits rnum seconds
	deats.pause()
	pframe = deats.get_frame()
		#text changes depending on which part of the wheel is landed on
	if (3 <= pframe and pframe <= 8):
		var plus = await deaths(pframe)
		await get_tree().create_timer(2).timeout
	else:
		edit_text("none of your animals died !", "cardAnim/cardText")
		await get_tree().create_timer(2*t).timeout

	await get_tree().create_timer(2*t).timeout
	cards.set_visible(false) #makes the cards invisible
	var wheelAnim = get_node("wheelAnim")
	var button = get_node("Button")
	wheelAnim.set_visible(true) #makes wheel visible
	button.set_visible(true)
	num = R.randi_range(0,19)
	spin_num -= 1 #subtracts the number of spins left by 1
	cards.set_frame(0)
	wheel()
	

func _on_coin_but_pressed() -> void:
	var coin = $cardAnim/coin
	var coinBut = $cardAnim/coinBut
	coinBut.set_visible(false)
	coin.play()

func set_tospin(b) -> void:
	tospin = b

func get_spins_left() -> bool:
	return spins_left

func set_spins_left(b) -> void:
	spins_left = b

func get_in_progress() -> bool:
	return in_progress
	
func set_in_progress(b) -> void:
	in_progress = b
	
func get_pigs() -> int:
	return pigs

func get_cows() -> int:
	return cows
	
func get_chickens() -> int:
	return chicken
	
func get_carrots() -> int:
	return carrot
	
func get_points() -> int:
	return points
	
func wheel_reset() -> void:
	R = RandomNumberGenerator.new()
	num = R.randi_range(0,19) #for the wheel
	randNum = R.randi_range(1,20) #for the cards
	frame = 21 #placeholder for the current frame number
	points = 0
	pigs = 0
	cows = 0
	chicken = 0
	carrot = 0
	tospin = false
