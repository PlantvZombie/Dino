extends Node

var speed_factor := 2.0
var speed = -100
var save_data:SaveData
var RunSpeed:int
var DinoPos:Vector2


func _ready() -> void:
	save_data = SaveData.load_or_create()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
