extends Node

var Level = 1
var PlayerHp = 3
var Gold = 0
var Gems = 0
var TimeElapsed := 0.0

func resetPlayerStats():
	PlayerHp = 3
	Gold = 0
	Gems = 0
	TimeElapsed = 0.0
	
func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
