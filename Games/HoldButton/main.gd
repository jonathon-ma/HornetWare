extends Node2D

const range = 1 

var target
var pressed
var time = 0

var won = 0

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	if pressed: 
		time += delta
	if time > target && $ButtonTimer.is_stopped(): 
		$ButtonTimer.start()

func _on_button_button_down() -> void:
	pressed = true

func _on_button_button_up() -> void:
	#time = $ButtonTimer.time_left
	set_actual()
	pressed = false
	$Button.disabled = true
	$ButtonTimer.start()

func _on_button_timer_timeout() -> void:
	#print("ended")
	check_win()
	reset()

func set_actual() :
	$ActualTime.text = "Actual Time " + str(snapped(time, .1))

func reset() :
	target = snapped(randf_range(2, 8), .1)
	$TargetTime.text = "Target Time = " + str(target)
	$ActualTime.text = ""
	#$ButtonTimer.wait_time = target + 2
	time = 0
	$Button.disabled = false

func check_win():
	if won >= 0 && abs((target + range) - time) < range :
		won = 1
	else: won = -1

func hasWon() -> bool:
	return won > 0
