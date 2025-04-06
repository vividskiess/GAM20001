extends AudioStreamPlayer

@onready var stream_peer := StreamPeerTCP.new()

func _ready() -> void:
	stream_peer.connect_to_host("ice1.somafm.com/groovesalad-128-mp3", 80)

	# Wait until connected (non-blocking)
	while stream_peer.get_status() != StreamPeerTCP.STATUS_CONNECTED:
		await get_tree().process_frame

	var http_req := "GET /groovesalad-128-mp3 HTTP/1.1\r\nHost: ice1.somafm.com\r\n\r\n".to_utf8_buffer()
	stream_peer.put_data(http_req)

	_start_streaming()

func _start_streaming() -> void:
	while true:
		var available := stream_peer.get_available_bytes()
		if available > 16000:
			var mp3_stream := AudioStreamMP3.new()
			var result := stream_peer.get_data(available)
			var err = result[0]
			var data = result[1]
			if err == OK:
				mp3_stream.data = data
				if playing:
					await self.finished
				stream = mp3_stream
				play()
