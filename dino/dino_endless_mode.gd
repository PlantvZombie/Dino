extends Node2D

@export var spawnLoc:Marker2D
@export_category("Area One")
@export var numObjArea1:int = 2
@export var sRock:PackedScene
@export var tRock:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func chooseRock(area:int):
	randomize()
	var item
	### AREA ONE ###
	if (area == 1):
		item = randi_range(1,numObjArea1)
	
	if (item == 1):
		add_child(sRock.new())
	if (item == 2):
		add_child(tRock.new())
	
	### AREA TWO ###
