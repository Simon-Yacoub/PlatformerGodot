extends Node

const SAVE_PATH = "res://savegame.bin"
const HIGHSCORE_PATH = "res://highscore.bin"
const TOTAL_GAME_LEVELS = 10
var record_book = {}

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
	loadRecordBook()

func saveTime():	
	if !record_book.has(str(Game.Level)):
		record_book[str(Game.Level)] = Game.TimeElapsed
	else:
		var previousTimeForThisLevel = record_book.get(str(Game.Level))
		if Game.TimeElapsed < previousTimeForThisLevel:
			record_book[str(Game.Level)] = Game.TimeElapsed			
	saveRecordBook()	
		
func saveRecordBook():
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.WRITE)
	var jstr = JSON.stringify(record_book)
	file.store_string(jstr)
	return
	
func loadRecordBook():
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ)
	if FileAccess.file_exists(HIGHSCORE_PATH):
		var json = JSON.new()
		var json_string = file.get_as_text()
		var error = json.parse(json_string)
		if error == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY:
				record_book = data_received
						
func getHighScore():
	if record_book.has(str(Game.Level)):
		return record_book.get(str(Game.Level))
	
func getRecords():
	var records = ""
	var keys = record_book.keys()
	var values = record_book.values()
	for x in TOTAL_GAME_LEVELS + 1:
		if record_book.has(str(x)):
			records += "Level " + str(x) + ": " + str(record_book.get(str(x))) + "\n"
	return records
		

