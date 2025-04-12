extends Node2D

@export var spawnLoc:Marker2D
@export var endLoc:Marker2D
const SPEED = 300
@export_category("Area One")
@export var numObjArea1:int = 2
@export var sRock:PackedScene
@export var tRock:PackedScene

var newRock



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func chooseRock(area:int):
	randomize()
	var rock
	var item
	### AREA ONE ###
	if (area == 1):
		item = randi_range(1,numObjArea1)
	
	if (item == 1):
		rock = sRock.instantiate()
		print("is_calle2d")
	if (item == 2):
		rock = tRock.instantiate()
		print("is_calle1d")
	print("is_called")
	rock.position = spawnLoc.position
	rock.move_toward(endLoc.position, SPEED)
	add_child(rock)
	### AREA TWO ###


func _on_rock_timer_timeout() -> void:
	chooseRock(1)
