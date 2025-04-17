extends Node
# root
var rot = get_tree().root
# if in vr
var vr:bool = false
var v
var player:Pooper
var target
# Do vr
func fart_vr():
	var viewport = get_viewport()
	viewport.hdr = false
	Engine.max_fps = 120
	

	if v.initialize():
		print("Failed to initialize VR!")
		return	
	viewport.arvr = true
	set_keys()
	var vr_av = load("res://3DPoop/pooper.tscn").instance()
	rot.add_child(vr_av)
	vr_av.name = "Pooper"
	player = vr_av
	target = "res://vr/sel.tscn"
	get_tree().change_scene("res://3DPoop/load.tscn")

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
	
	ev = InputEventJoypadMotion.new()
	ev.axis = "aim_pose"
	InputMap.action_add_event("aim", ev)
	
#Main
func fart(s:int):
	match(s):
		0:
			var interface = XRServer.find_interface("OpenVR")
			if interface:
				v = interface
				Clawping.fart_vr()
		1:
			
