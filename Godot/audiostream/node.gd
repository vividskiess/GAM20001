extends Node

func _ready():
	print("Loaded classes:")
	var class_list = ClassDB.get_class_list()
	for i in class_list:
		if "ffmpeg" in i.to_lower():
			print(i)
