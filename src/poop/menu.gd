extends Area3D
var viewport:Viewport 
@export var size:Vector2

var last_screen_pos:Vector2 = Vector2(0,0)
var active:bool = false # Cursor is on this screen

func _input(event: InputEvent):
	if active:
		if Input.is_action_just_pressed("click"):
			var ev:InputEventMouseButton = InputEventMouseButton.new()
			ev.position = last_screen_pos
			ev.button_index = MOUSE_BUTTON_LEFT
			ev.pressed = event.pressed  # Set pressed state based on action
			viewport.input(ev)
				
		
			
	
			

func _process(delta):
	if Clawping.menuR:
		var pooper=Clawping.player
		active = (pooper.primary_ray.is_colliding() and (pooper.primary_ray.get_collider() == self))
		if active:
			# Cursor
			var p = pooper.primary_ray.get_collision_point()
			
			var lp3 = p * global_transform
			var local_pos = Vector2(lp3.x,lp3.y)
			var percent = Vector2(
				clamp((local_pos.x + (size.x/2.0)) / size.x,  0,1),
				clamp(1.0 - ((local_pos.y + (size.y/2.0)) / size.y),  0,1)
			)
			var screen_pos = Vector2(
				round(percent.x * viewport.size.x),
				round(percent.y * viewport.size.y)
			)
			if screen_pos != last_screen_pos:
				var ev:InputEventMouseMotion = InputEventMouseMotion.new()
				var relative = screen_pos - last_screen_pos
				ev.relative = relative
				ev.speed = relative / delta
				ev.pressure = Input.get_action_raw_strength("vr_click")
				ev.position = screen_pos
				ev.global_position = screen_pos
				
				viewport.input(ev)
				last_screen_pos = screen_pos
			


func _ready():
	
	viewport = get_node("MenuVP")
	
