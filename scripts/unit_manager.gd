extends Node

var selected_rect :Rect2: 
	set(value):
		selected_rect = value
		select_units()
		
var selected_units :Array[CharacterBody2D] = []

func select_units() -> void:
	
	for unit in selected_units:
		unit.deselect()
	
	selected_units.clear()

	for unit in get_tree().get_nodes_in_group("Unit"):
		if selected_rect.has_point(unit.global_position):
			unit.select()
			selected_units.append(unit)
		else:
			unit.deselect()
			
	#print(selected_units)
		
func get_formation_positions(center_pos: Vector2, unit_count: int) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	
	if unit_count == 1:
		positions.append(center_pos)
		return positions
	
	const SPACING := 20
	
	var cols = ceil(sqrt(unit_count))
	var rows = ceil(unit_count / cols)
	var start_x = center_pos.x - (cols - 1) * SPACING 
	var start_y = center_pos.y - (rows - 1) * SPACING 
			
	for i in range(unit_count):
		var col = i % int(cols)
		var row = i / int(cols)
		var pos = Vector2(start_x + col * SPACING, start_y + row * SPACING)
		positions.append(pos)
	
	return positions
	
func has_selected_units() -> bool:
	return not selected_units.is_empty()

func clear_selection() -> void:
	for unit in selected_units:
		unit.deselect()
	selected_units.clear()
	
func move_to_pos(world_pos: Vector2) -> void:
	if selected_units.is_empty():
		return
		
	var formation_positions = get_formation_positions(world_pos, selected_units.size())
	
	for i in range(selected_units.size()):
		selected_units[i].move_to(formation_positions[i])
