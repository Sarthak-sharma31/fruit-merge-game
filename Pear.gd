extends RigidBody2D

var spawn = load("res://Scenes/MiniPine.tscn")
var Index : int = 0

func pear():
	pass

func _on_Area2D_body_entered(body):
	if body.has_method("pear") and body.Index != Index:
		queue_free()
		
		if Index < body.Index:
			var newFruitInstance = spawn.instance()
			newFruitInstance.position = position
			newFruitInstance.Index = Index
			get_parent().add_child(newFruitInstance)
