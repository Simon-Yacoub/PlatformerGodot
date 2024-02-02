extends Node

const SAVE_PATH = "res://savegame.bin"
const HIGHSCORE_PATH = "res://highscore.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"PlayerHP": Game.PlayerHp,
		"Gold": Game.Gold		
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr) 
	file.close()

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.PlayerHp = current_line["PlayerHP"]
				Game.Gold = current_line["Gold"]
	file.close()

func saveTime():	
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ_WRITE)
	if FileAccess.file_exists(HIGHSCORE_PATH):
		if not file.eof_reached():
			var current_line = ""
			# Jump to line with level and score for that level 
			for x in Game.Level:
				current_line = JSON.parse_string(file.get_line())
			if !current_line: #If empty overwrite line
				var data: Dictionary = {str(Game.Level) : Game.TimeElapsed}
				var jstr = JSON.stringify(data)
				file.store_line(jstr)
			elif current_line.has(str(Game.Level)): # if there is a score compare it and then overwrite it or do nothing
				var previousTimeForThisLevel = current_line[str(Game.Level)]
				if previousTimeForThisLevel:
					if Game.TimeElapsed < previousTimeForThisLevel:
						var data: Dictionary = {str(Game.Level) : Game.TimeElapsed}
						var jstr = JSON.stringify(data)
						file.seek(0)
						for x in Game.Level - 1:
							current_line = JSON.parse_string(file.get_line())									
						file.store_line(jstr)
			else:
				var data: Dictionary = {str(Game.Level) : Game.TimeElapsed}
				var jstr = JSON.stringify(data)
				file.seek(0)
				for x in Game.Level - 1:
					current_line = JSON.parse_string(file.get_line())									
					file.store_line(jstr)
			file.close()
	else:
		file = FileAccess.open(HIGHSCORE_PATH, FileAccess.WRITE)
		var data: Dictionary = {str(Game.Level) : Game.TimeElapsed}
		var jstr = JSON.stringify(data)
		file.store_line(jstr)	
		file.close()
						
func getHighScore():
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ)
	if FileAccess.file_exists(HIGHSCORE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			for x in Game.Level - 1:
				current_line = JSON.parse_string(file.get_line())
			if current_line:
				return current_line[str(Game.Level)]			
	file.close()	
	
func getRecords():
	var records = ""
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ)
	if FileAccess.file_exists(HIGHSCORE_PATH):
		while not file.eof_reached():
			records += file.get_line() + "\n"		
	return records
	file.close()	
		

