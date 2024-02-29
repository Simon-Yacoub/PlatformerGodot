extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if Game.Gems >= 3:
			Utils.saveTime()
		get_tree().change_scene_to_file("res://level_complete.tscn")
