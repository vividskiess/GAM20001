extends Node

var extensionDir := ProjectSettings.globalize_path("res://extensions")
var ffplay := extensionDir + "/ffmpeg/bin/ffplay.exe"
var ytdlp = extensionDir + "/yt-dlp/yt-dlp.exe"

var ffplay_app: int = -1
var ffplay_args: Array = []
# var stream_url := "https://www.youtube.com/watch?v=aqpCYTF0YWs"
var audio_stream := "https://fr3.1mix.co.uk:8060/128"

func _ready() -> void:
	
	if not FileAccess.file_exists(ffplay) or not FileAccess.file_exists(ytdlp): 
		push_error("ffplay or ytdpl does not exist extension directory.")
		return
	
	print("ffplay: ", ffplay)
	print("ytdlp: ", ytdlp)

	
	var output: Array = []
	# var result: int = OS.execute(ytdlp, ["-g", "-f", "bestaudio", "--audio-quality", "0", stream_url], output)
	# var result: int = OS.execute(ffplay, ["-g", "-f", "bestaudio", "--audio-quality", "0", stream_url], output)

	# if result != 0 or output.size() == 0:
	# 	push_error("Could not get output from youtube link.")
	# 	return

	# var audio_stream: String = output[0].strip_edges()
	# print("Audio stream: ", audio_stream)
	
	# if audio_stream == "":
	# 	push_error("Audio stream is empty.")
	# 	return

	ffplay_app = OS.create_process(ffplay, [audio_stream, "-nodisp", "-autoexit", "-volume", "10"])

	if ffplay_app > 0:
		print("ffplay started")
	else:
		push_error("Something went wrong with ffplay")

func _exit_tree() -> void:
	if ffplay_app > 0: OS.kill(ffplay_app)
