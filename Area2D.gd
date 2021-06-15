extends Area2D

export(PackedScene) var target_stage
export(bool) var closing_animation = false
export(int) var key_needed = 0


export(PackedScene) var key_alert


var player_body = null

func _ready():
	player_body = null # to be sure
	
	$Key_alert.queue_free()
	
	if closing_animation:
		$ani.play("close")




func _on_Door_body_entered(body):
	player_body = body

func _on_Door_body_exited(body):
	player_body = null

func _process(delta):

	if Input.is_action_just_pressed('game_use'):
		if !target_stage:
			return
		
		if player_body:
			if player_body.key < key_needed:
				show_key_alert((key_needed - player_body.key))
				return
			player_body.walk_in(get_node("."))

func open_ani():
	$ani.play("open")
	

func next_level():
	if !target_stage:
		return
	
	#Global.music_playback_time = get_tree().current_scene.Music.get_playback_position()
	#Global.save_playback_time_using_scene(get_tree().current_scene)
	
	var er = get_tree().change_scene_to(target_stage)
	if er != OK:
		print("Failed to change scene using Door")

func show_key_alert(key):
	var key_alert_ins = key_alert.instance()
	key_alert_ins.key_count = key
	key_alert_ins.position = Vector2(5, -35)
	key_alert_ins.scale = Vector2(1.5, 1.5)
	
	add_child(key_alert_ins)

