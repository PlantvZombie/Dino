extends Node2D

@export var spawnLoc:Marker2D
@export var endLoc:Marker2D
const SPEED = 300
@export_category("Area One")
@export var numObjArea1:int = 2
@export var sRock:PackedScene
@export var tRock:PackedScene
@export var platform:PackedScene

var rock
var plat
var countdown:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 2
	plat = platform.instantiate()
	plat.position = endLoc.position
	add_child(plat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !countdown:
		countdown = true
		await get_tree().create_timer(4.785).timeout
		plat = platform.instantiate()
		plat.position = endLoc.position
		add_child(plat)
		countdown = false



func chooseRock(area:int):
	randomize()
	var item
	### AREA ONE ###
	if (area == 1):
		item = randi_range(1,numObjArea1)
	
	if (item == 1):
		rock = sRock.instantiate()
	if (item == 2):
		rock = tRock.instantiate()
	rock.position = spawnLoc.position
	add_child(rock)
	### AREA TWO ###


func _on_rock_timer_timeout() -> void:
	chooseRock(1)
	$RockTimer.wait_time = randf_range(1.5, 3.0)
