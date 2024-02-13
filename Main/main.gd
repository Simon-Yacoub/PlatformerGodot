extends Node2D

func _ready():
	Utils.saveGame()
	Utils.loadGame()

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	Game.resetPlayerStats()
	get_tree().change_scene_to_file("res://Levels/level1.tscn")


func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://level_select.tscn")

func _on_record_book_pressed():
	get_tree().change_scene_to_file("res://record_book.tscn")
