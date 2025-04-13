extends Node2D

@export var spawnLoc:Marker2D
@export var endLoc:Marker2D
const SPEED = 300
@export_category("Area One")
@export var numObjArea1:int = 2
@export var sRock:PackedScene
@export var tRock:PackedScene
@export var wRock:PackedScene
@export var waRock:PackedScene
@export_category("Area Two")
@export var numObjArea2:int = 2
@export var stalacT:PackedScene
@export var stalacM:PackedScene
@export_category("Platforms")
@export var platform:PackedScene
@export var cavePlatform:PackedScene
var currArea = 1
var rock
var plat
var countdown:bool = false
var timer = 0.0
var score = 0
var level = 1

@export var speed_factor := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Label.text = "Score: %s" % score
	plat = platform.instantiate()
	plat.position = endLoc.position
	add_child(plat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta *= $/root/Global.speed_factor
	timer += delta
	if timer >= 4.783:
		timer -= 4.783
		if currArea == 1:
			plat = platform.instantiate()
		if currArea == 2:
			plat = cavePlatform.instantiate()
		plat.position = endLoc.position
		add_child(plat)
		#await get_tree().create_timer(4.785).timeout



func chooseRock(area:int):
	var item
	### AREA ONE ###
	if (area == 1):
		item = randi_range(1,numObjArea1)
		if (item == 1):
			rock = sRock.instantiate()
		if (item == 2):
			rock = tRock.instantiate()
		if (item == 3):
			rock = wRock.instantiate()
		if (item == 4):
			rock = waRock.instantiate()
	else:
		item = randi_range(1, 2)
		if (item == 1):
			rock = stalacT.instantiate()
		if (item == 2):
			rock = stalacM.instantiate()
	rock.position = spawnLoc.position
	add_child(rock)
	### AREA TWO ###


func _on_rock_timer_timeout() -> void:
	randomize()
	chooseRock(currArea)
	$RockTimer.wait_time = randf_range(0.7, 1.5)


func _on_timer_timeout() -> void:
	score += 1
	if score < 2000:
		$/root/Global.speed_factor += 0.001
	elif score < 1000:
		$/root/Global.speed_factor += 0.0015
	else:
		$/root/Global.speed_factor += 0.003
	if score % 500 == 0:
		speed_factor -= 2.5
		level += 1
		currArea = level % 3
	$CanvasLayer/Label.text = "Score: %s" % score
	$CanvasLayer/Level.text = "\nLevel: %s" % level
