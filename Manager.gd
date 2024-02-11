extends StaticBody2D

var margin: float = 10  # Adjust this value to add some margin to the corners
var FruitIndex: int = 0
onready var left__collision = $Left_Collision
onready var right__collision = $Right_Collision

onready var Sprite_1 = $"CanvasLayer/Top/Btns/Right/Upcoming/1/Sprite"
onready var Sprite_2 = $"CanvasLayer/Top/Btns/Right/Upcoming/2/Sprite"
onready var Sprite_3 = $"CanvasLayer/Top/Btns/Right/Upcoming/3/Sprite"

var random_number = 0
var Spawn = 0
var Spawn_1 = 0
var Spawn_2 = 0
var Spawn_3 = 0
var get_new_num = false

var Blue_Berry = preload("res://Scenes/BlueBerry.tscn")
var Straw_Berry = preload("res://Scenes/StrawBerry.tscn")
var Cherry = preload("res://Scenes/Cherry.tscn")
var Pinki = preload("res://Scenes/Pinki.tscn")
var PurpleBerry = preload("res://Scenes/PurpleBerry.tscn")

#Visualize Fruits
var V_BlueBerry = preload("res://Scenes/V_BlueBerry.tscn")
var V_StrawBerry = preload("res://Scenes/V_Strawberry.tscn")
var V_Cherry = preload("res://Scenes/V_Cherry.tscn")
var V_Pinki = preload("res://Scenes/V_Pinki.tscn")
var V_Purple = preload("res://Scenes/V_Purple.tscn")

var V_newFruit_1

var upcomingFruits = []

func _ready():
	randomize()
	get_new_num = true
	FruitIndex = 0
	Spawn = 0
	set_corner_positions()
	get_viewport().connect("size_changed", self, "_on_screen_resized")
	set_process_input(true)
	
	# Generate the initial random number and display upcoming fruits
	randomNumber()
	displayUpcomingFruits()

func randomNumber():
	random_number = randi() % 5

func displayUpcomingFruits():
	# Clear previous upcoming fruits
	upcomingFruits.clear()
	
	if get_new_num:
		for i in range(4):
			var upcomingNumber = (random_number + i) % 5
			upcomingFruits.append(upcomingNumber)
		Spawn = upcomingFruits[0]
		Spawn_1 = upcomingFruits[1]
		Spawn_2 = upcomingFruits[2]
		Spawn_3 = upcomingFruits[3]
	
	print(Spawn, Spawn_1, Spawn_2, Spawn_3)
	Visualize()
	


func Visualize():
	var V_fruitInstance: PackedScene
	
	if Spawn_1 == 0:
		V_fruitInstance = V_BlueBerry
	elif Spawn_1 == 1:
		V_fruitInstance = V_StrawBerry
	elif Spawn_1 == 2:
		V_fruitInstance = V_Purple
	elif Spawn_1 == 3:
		V_fruitInstance = V_Pinki
	elif Spawn_1 == 4:
		V_fruitInstance = V_Cherry
	
	V_newFruit_1 = V_fruitInstance.instance()
	V_newFruit_1.position = Sprite_1.position
	add_child(V_newFruit_1)


func set_corner_positions():
	var screen_size = get_viewport_rect().size

	$Left_Collision.position.x = 0
	$Left_Collision.position.y = screen_size.y / 2

	$Right_Collision.position.x = screen_size.x
	$Right_Collision.position.y = screen_size.y / 2

func spawnRandomFruitAtClick():
	var mousePos = get_global_mouse_position()
	spawnRandomFruit(mousePos, FruitIndex)

func spawnRandomFruit(position: Vector2, index: int):
	var fruitInstance: PackedScene

	# Use the initial random number to determine the first spawned fruit
	if Spawn == 0:
		fruitInstance = Blue_Berry
	elif Spawn == 1:
		fruitInstance = Straw_Berry
	elif Spawn == 2:
		fruitInstance = PurpleBerry
	elif Spawn == 3:
		fruitInstance = Pinki
	elif Spawn == 4:
		fruitInstance = Cherry

	var newFruit = fruitInstance.instance()
	newFruit.position = position
	newFruit.Index = index
	add_child(newFruit)
	FruitIndex += 1
	displayUpcomingFruits()
	get_new_num = false
	fix_Upcoming()
	

func fix_Upcoming():
	Spawn = Spawn_1
	Spawn_1 = Spawn_2
	Spawn_2 = Spawn_3
	Spawn_3 = randi() % 4

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		spawnRandomFruitAtClick()
