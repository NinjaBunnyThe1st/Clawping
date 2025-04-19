extends XRController3D

@onready var player_body:Node3D = get_parent().get_parent()
@onready var hand:Area3D = $h
var is_climbing = false
var fall = false
var climbable_mesh: MeshInstance3D
var initial_hand_position: Vector3
var initial_player_position: Vector3
var ti:bool=false
func _ready():
	ProjectSettings.set_setting("physics_engine/3d/jolt/collisions/areas_detect_static_bodies", true)
	hand.monitoring = true
	hand.collision_layer = 1  # Hands layer
	hand.collision_mask = 2   # Climbable surfaces layer
	connect("button_pressed",_on_trigger_pressed)
	connect("button_released",_on_trigger_released)

func _physics_process(_delta):
	if Clawping.player.climbing and is_climbing:
		var hand_delta = global_transform.origin - initial_hand_position
		player_body.global_transform = Transform3D.IDENTITY.translated(
			initial_player_position + hand_delta
		)
	if fall and !Clawping.player.on_fl:
		var the = player_body.global_position - Vector3(0,0.05,0)
		player_body.global_transform = Transform3D.IDENTITY.translated(the)
		
	
func _on_trigger_pressed(t):
	if t=="trigger_click":
		print("ok")
		if Clawping.player.climbing:
			print("real")
			is_climbing = true
			initial_hand_position = global_transform.origin
			initial_player_position = player_body.global_transform.origin

func _on_trigger_released(t):
	if t=="trigger_click":
		ti=false
		is_climbing = false
		if Clawping.player.climbing:
			fall = true



	
