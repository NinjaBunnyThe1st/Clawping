extends Node
var target
func stage(text:String,done:bool=false):
	$SubViewport/Label3D.text = text
	if done:
#		black_fade_target = true
		$SubViewport/Label3D.text = "Loading menu"
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://3DPoop/loaders/loadm.tscn")
		
func _ready():
	get_tree().paused = false
	Clawping.connect("farted",Callable.create(self,"stage"),2)
	Clawping.fart()
	
