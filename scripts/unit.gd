extends CharacterBody2D

var selection_rect := Rect2()
		
var is_selected := false
		
func select():
	is_selected = true
	selection_rect = Rect2(Vector2(-7,-7),Vector2(16,16))
	queue_redraw()
	
 
func deselect():
	is_selected = false	
	selection_rect = Rect2()
	queue_redraw()
	
func _ready() -> void:
	name = "TID_UNIT"
	
func _draw() -> void:
	draw_rect(selection_rect,Color.LIME_GREEN,false)
	
func _physics_process(delta: float) -> void:
	pass
