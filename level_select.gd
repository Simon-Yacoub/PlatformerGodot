extends Node2D



func _on_level_1_pressed():
	Game.Level = 1
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level1.tscn")
	


func _on_level_2_pressed():
	Game.Level = 2
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level2.tscn")


func _on_level_3_pressed():
	Game.Level = 3
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level3.tscn")


func _on_level_4_pressed():
	Game.Level = 4
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level4.tscn")


func _on_level_5_pressed():
	Game.Level = 5
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level5.tscn")


func _on_level_6_pressed():
	Game.Level = 6
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level6.tscn")


func _on_level_7_pressed():
	Game.Level = 7
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level7.tscn")


func _on_level_8_pressed():
	Game.Level = 8
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level8.tscn")


func _on_level_9_pressed():
	Game.Level = 9
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level9.tscn")


func _on_level_10_pressed():
	Game.Level = 10
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level10.tscn")

