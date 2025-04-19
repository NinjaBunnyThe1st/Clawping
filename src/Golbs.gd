extends Node
func p(path:String) -> String:
	var base_path = "user://"
	if OS.has_feature("Android"):
		base_path = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP, false) + "/" #OS.get_user_data_dir() + "/"
	return path.replace("user://",base_path)
