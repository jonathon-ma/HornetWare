extends Node2D

const RADIUS = 25
const SIZE = Vector2(200, 100)

var draw_pos

func _draw() -> void:
	if !draw_pos: return
	#draw_circle(draw_pos, 100, Color.WHITE)
	#draw_rect(Rect2(draw_pos - Vector2(100, 50), Vector2(200, 100)), Color.WHITE)
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(RADIUS)
	style_box.set_bg_color(Color.WHITE)
	draw_style_box(style_box, Rect2(draw_pos - SIZE/2, SIZE))

func drawAt(pos):
	draw_pos = pos
	queue_redraw()
