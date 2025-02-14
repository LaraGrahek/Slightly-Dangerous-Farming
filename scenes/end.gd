extends Node2D

var points = 1
var done = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	done = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var point = $point
	var money = $money
	if (points != 1):
		point.clear() 
		point.add_text(str(points))
		money.clear()
		money.add_text(str(points/2))
		print("45454545454")
	


func send_points(n) -> void:
	points = n

func _on_restart_pressed() -> void:
	set_visible(false)
	done = 3
	points = 1
	
func get_done() -> int:
	return done

func set_done(n) -> void:
	done = n
	
func set_points(n) -> void:
	points = n
