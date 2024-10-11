extends RigidBody2D
const pull_strength = 2000

var mouse_inside = false
var click_pos

func _on_mouse_entered() -> void:
	mouse_inside = true
	#print("entered" + str(mouse_inside))

func _on_mouse_exited() -> void:
	mouse_inside = false
	#print("exited" + str(mouse_inside))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("LClick") && !mouse_inside: click_pos = null
	if Input.is_action_pressed("LClick") && click_pos != null:
		var current_pos = get_local_mouse_position()
		apply_force(Vector2(current_pos - click_pos).normalized()
		 * pull_strength
		 * abs(current_pos - click_pos) / 5, click_pos)
		#print("impulse")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if mouse_inside && Input.is_action_just_pressed("LClick"):
		click_pos = get_local_mouse_position()

func get_rect() -> Rect2:
	return $ColorRect.get_rect()
