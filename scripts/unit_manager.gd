extends Node

var selected_rect :Rect2: 
	set(value):
		selected_rect = value
		select_units()
		
var selected_units :Array[CharacterBody2D] = []

func select_units() -> void:
	
	selected_units.clear()
	
	for unit in get_tree().get_nodes_in_group("Units"):
		if selected_rect.has_point(unit.global_position):
			unit.select()
			selected_units.append(unit)
		else:
			unit.deselect()
			
	print(selected_units)
		
