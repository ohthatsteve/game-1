extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.modulate.a = .75
	
func _on_body_exited(body: Node2D) -> void:
	body.modulate.a = 1
