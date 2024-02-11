extends RigidBody2D

var BlueBerry = load("res://Scenes/BlueBerry.tscn")
var Index : int = 0
onready var tween: Tween = $Tween

func _ready():
	# Call the function to initiate the bounce effect
	bounce()

func bounce():
	# Clear any previous tweens
	tween.stop_all()

	# Set the initial position of the fruit
	var initial_position = position

	# Define the bounce parameters (you can adjust these values)
	var bounce_height = 10.0
	var bounce_duration = 0.3

	# Create the bounce animation
	tween.interpolate_property(self, "position:y", initial_position.y, initial_position.y - bounce_height, bounce_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)

	# Connect the bounce function to the tween's "tween_completed" signal
	tween.connect("tween_completed", self, "_on_bounce_completed")

	# Start the tween
	tween.start()

func Watermellon():
	pass

func _on_Area2D_body_entered(body):
	if body.has_method("Watermellon") and body.Index != Index:
		queue_free()
		
		if Index < body.Index:
			var newFruitInstance = BlueBerry.instance()
			newFruitInstance.position = position
			newFruitInstance.Index = Index
			get_parent().add_child(newFruitInstance)
