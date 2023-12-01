extends Node2D



func _on_level_1_pressed():
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://level1.tscn")
	


func _on_level_2_pressed():
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://level2.tscn")
