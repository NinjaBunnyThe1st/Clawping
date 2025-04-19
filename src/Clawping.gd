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
var lefth:bool=false
var menuR:bool=false
# audio
var sound:AudioStream
func fart_vr():
	fartface = v
	if fartface and fartface.is_initialized():
		print("The fart is real")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
	else: print("No fart :_(")
	set_keys()
	var vr_av = load("res://3DPoop/pooper.tscn").instantiate()
	var the=get_tree().root.add_child
	the.call_deferred(vr_av)
	vr_av.name = "Pooper"
	player = vr_av
	

func set_keys():
	
	var ev = InputEventAction.new()
	ev.action = "Trigger click"
	InputMap.action_add_event("click", ev)
	
	ev = InputEventAction.new()
	ev.action = "menu-button"
	InputMap.action_add_event("pause", ev)
	
	ev = InputEventAction.new()
	ev.action = "by_button"
	InputMap.action_add_event("back", ev)
	
	ev = InputEventAction.new()
	ev.action = "primary_click"
	InputMap.action_add_event("sh", ev)
	
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
	emit_signal("farted","real",true)
	
func make_poop(_data:Array):
	var _path=Golbs.p("")
	
func get_stream(path: String, default: AudioStream) -> AudioStream:
	path = Golbs.p(path)
	var file = FileAccess.open(path + ".ogg", FileAccess.READ)
	if file == null:
		file = FileAccess.open(path + ".mp3", FileAccess.READ)
		if file == null:
			file = FileAccess.open(path + ".wav", FileAccess.READ)
			if file == null:
				return default
			path += ".wav"
		else:
			path += ".mp3"
	else:
		path += ".ogg"

	if !path.begins_with("res://"):
		var stream = Golbs.audioLoader.load_file(path)
		if stream is AudioStream:
			return stream
	else:
		var mf = load(path) as AudioStream
		if mf is AudioStream:
			return mf

	return default
