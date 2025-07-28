extends Node2D

var is_drawing := false
var start_pos := Vector2.ZERO
var end_pos := Vector2.ZERO
var selection_rect := Rect2()

func _draw() -> void:
	var rect_pos = start_pos
	var rect_size = end_pos - start_pos
	
	if rect_size.x < 0:
		rect_pos.x += rect_size.x
		rect_size.x = abs(rect_size.x)
	
	if rect_size.y < 0:
		rect_pos.y += rect_size.y
		rect_size.y = abs(rect_size.y)
	
	selection_rect = Rect2(rect_pos,rect_size)
	
	draw_rect(selection_rect,Color(0.80, 0.36, 0.36, 0.5))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index  == MOUSE_BUTTON_LEFT:
			is_drawing = true
			start_pos = event.position
			end_pos = event.position
			
		if event.is_released() and event.button_index  == MOUSE_BUTTON_LEFT:
			is_drawing = false
			start_pos = Vector2.ZERO
			end_pos = Vector2.ZERO
			queue_redraw()
		
	if event is InputEventMouseMotion && is_drawing:
		end_pos = event.position
		queue_redraw()
	
