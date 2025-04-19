extends XRController3D

@onready var player_body = get_parent().get_parent()
@onready var hand_mesh = $MeshInstance3D
var is_climbing = false
var climbable_mesh: MeshInstance3D
var initial_hand_position: Vector3
var initial_player_position: Vector3

func _ready():
	# Ensure Jolt physics is set up for static body detection
	ProjectSettings.set_setting("physics_engine/3d/jolt/collisions/areas_detect_static_bodies", true)
	
	# Connect trigger events
	connect("button_pressed",_on_trigger_pressed)
	connect("button_released",_on_trigger_released)
func _physics_process(_delta):
	if is_climbing:
		# Calculate hand movement delta
		var hand_delta = global_transform.origin - initial_hand_position
		
		# Move player body to follow hand
		player_body.global_transform = Transform3D.IDENTITY.translated(
			initial_player_position + hand_delta
		)

func _on_trigger_pressed(t):
	print("lol")
	# Raycast from controller to detect climbable surfaces
	var space_state = get_world_3d().direct_space_state
	var raycast = PhysicsRayQueryParameters3D.new()
	raycast.from = global_transform.origin
	raycast.to = global_transform.origin - global_transform.basis.z * 0.5
	raycast.collision_mask = 1  # Climbing layer
	
	var result = space_state.intersect_ray(raycast)
	
	if result:
		print("moce")
		climbable_mesh = result.collider as MeshInstance3D
		if climbable_mesh:
			print("real")
			is_climbing = true
			initial_hand_position = global_transform.origin
			initial_player_position = player_body.global_transform.origin

func _on_trigger_released(t):
	is_climbing = false
	climbable_mesh = null
