extends Node2D

@onready var Heart1 = get_node("Heart")
@onready var Heart2 = get_node("Heart2")
@onready var Heart3 = get_node("Heart3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
			
func _process(delta): 
	match Game.PlayerHp:
		0:
			Heart1.modulate = Color(0, 0, 0)
			Heart2.modulate = Color(0, 0, 0)
			Heart3.modulate = Color(0, 0, 0)
		1:
			Heart1.modulate = Color(0, 0, 0)
			Heart2.modulate = Color(0, 0, 0)
		2:
			Heart1.modulate = Color(0, 0, 0)
			Heart2.modulate = Color(Color.WHITE)
		_:
			Heart1.modulate = Color(Color.WHITE)
			Heart2.modulate = Color(Color.WHITE)
			Heart3.modulate = Color(Color.WHITE)
