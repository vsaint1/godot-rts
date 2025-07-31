extends Node2D

var is_drawing := false
var is_move_enabled := false
var start_pos := Vector2.ZERO
var end_pos := Vector2.ZERO
var selection_rect := Rect2()
var is_dragging := false
var drag_threshold := 5.0  # Minimum pixels to consider it a drag
@export var ground: TileMapLayer = null

func _draw() -> void:
	if not is_drawing:
		return
		
	var rect_pos = start_pos
	var rect_size = end_pos - start_pos
	
	if rect_size.x < 0:
		rect_pos.x += rect_size.x
		rect_size.x = abs(rect_size.x)
	
	if rect_size.y < 0:
		rect_pos.y += rect_size.y
		rect_size.y = abs(rect_size.y)
	
	selection_rect = Rect2(rect_pos, rect_size)
	draw_rect(selection_rect, Color(0.80, 0.36, 0.36, 0.3))

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
			is_drawing = true
			is_dragging = false
			start_pos = event.position
			end_pos = event.position
			
		if event.is_released() && event.button_index == MOUSE_BUTTON_LEFT:
			is_drawing = false
			
			# Check if it was a drag (selection) or click (move command)
			var drag_distance = start_pos.distance_to(end_pos)
			
			if drag_distance < drag_threshold and not is_dragging:
				# Single click - move selected units and clear selection
				if UnitManager.has_selected_units():
					UnitManager.move_to_pos(event.global_position)
					UnitManager.clear_selection()
			else:
				# It was a drag - selection happened during motion
				pass
			
			start_pos = Vector2.ZERO
			end_pos = Vector2.ZERO
			queue_redraw()
			
		
	if event.is_action_pressed("ui_cancel"):
		if UnitManager.has_selected_units():
			UnitManager.clear_selection()
			
	if event is InputEventMouseMotion && is_drawing:
		end_pos = event.position
		
		# Check if we've moved enough to consider it a drag
		if start_pos.distance_to(end_pos) > drag_threshold:
			is_dragging = true
			queue_redraw()
			UnitManager.selected_rect = selection_rect
