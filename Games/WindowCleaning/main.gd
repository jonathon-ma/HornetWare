extends Node2D

const clear_percent = .1
const spacing = 100

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#print("x: " + str(screen_size.x))
	#print("y: " + str(screen_size.y))

func _process(delta: float):
	#if Input.is_action_pressed("Paint"):
	$MaskViewport/Mask.drawAt($Wiper.position)
	
	await RenderingServer.frame_post_draw
	
	var texture = $MaskViewport.get_texture()
	
	$DirtyWindow.material.set_shader_parameter("mask_texture", texture)

func hasWon() -> bool:
	var count = 0
	
	var texture = $MaskViewport.get_texture()
	var image = texture.get_image()
	for x in range(0, screen_size.x, spacing): 
		for y in range(0, screen_size.y, spacing):
			if image.get_pixel(x,y) == Color(1,1,1,0): count += 1
	print("Matched Points: " + str(count))
	return (screen_size.x / spacing) * (screen_size.y / spacing) * clear_percent < count

func _on_timer_timeout() -> void:
	print("has won: " + str(hasWon()))
