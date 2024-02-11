extends RigidBody2D

var Spawn = load("res://Scenes/YellowApple.tscn")
var Index : int = 0

func cherry():
	pass

func _on_Area2D_body_entered(body):
	if body.has_method("cherry") and body.Index != Index:
		queue_free()
		
		if Index < body.Index:
			var newFruitInstance = Spawn.instance()
			newFruitInstance.position = position
			newFruitInstance.Index = Index
			get_parent().add_child(newFruitInstance)
