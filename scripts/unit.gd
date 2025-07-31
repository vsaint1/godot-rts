extends CharacterBody2D

enum UNIT_STATE {
	IDLE,
	WALKING,
	LUMBERING,
	MINING
}

var selection_rect := Rect2()
var is_selected := false
var target_position: Vector2
var speed := 150.0
var state = UNIT_STATE.IDLE
	
func _ready() -> void:
	name = "TID_UNIT"
	
func _draw() -> void:
	draw_rect(selection_rect,Color.LIME_GREEN,false)

	
func _physics_process(delta: float) -> void:
	if state == UNIT_STATE.WALKING:
		var direction = (target_position - global_position).normalized()
		var distance_to_target = global_position.distance_to(target_position)
		
		if distance_to_target < 10.0:
			state = UNIT_STATE.IDLE
			velocity = Vector2.ZERO
		else:
			velocity = direction * speed
		
		move_and_slide()
	
func select():
	is_selected = true
	selection_rect = Rect2(Vector2(-8,-8),Vector2(16,16))
	queue_redraw()
	
 
func deselect():
	is_selected = false	
	selection_rect = Rect2()
	queue_redraw()

				
func move_to(pos: Vector2):
	target_position = pos
	state = UNIT_STATE.WALKING
