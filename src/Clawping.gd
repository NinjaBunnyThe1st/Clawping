extends Node
# root
signal farted
# if in vr
var vr:bool = false
var v
var player:Pooper
var target
# Do vr
var farter:bool=false
var fir_fart:bool=false
var fartface:XRInterface

func fart_vr():
	fartface = v
	if fartface and fartface.is_initialized():
		print("The fart is real")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
	else: print("No fart :_(")
	set_keys()
	var vr_av = load("res://3DPoop/pooper.tscn").instantiate()
	var y=await get_tree().root.add_child.call_deferred(vr_av)
	if y==OK:
		print("nice")
	vr_av.name = "Pooper"
	player = vr_av
	target = "res://3DPoop/sel.tscn"
	get_tree().change_scene_to_file("res://3DPoop/loaders/loadm.tscn")

func set_keys():
	
	var ev = InputEventAction.new()
	ev.action = "trigger_click"
	InputMap.action_add_event("click", ev)
	
	ev = InputEventAction.new()
	ev.action = "grip_click"
	InputMap.action_add_event("pause", ev)
	
	ev = InputEventAction.new()
	ev.action = "by_button"
	InputMap.action_add_event("back", ev)
	
	#ev = InputEventAction.new()
	#ev.axis = "aim_pose"
	#InputMap.action_add_event("aim", ev)
	
#Main
func fart():
	emit_signal("farted","Loading Pooper!!!")	
	var interface = XRServer.find_interface("OpenXR")
	interface.initialize()
	v = interface
	Clawping.fart_vr()
	emit_signal("farted","Hello Pooper!!!11")	
