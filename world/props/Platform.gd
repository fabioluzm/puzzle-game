extends Area2D
class_name Platform

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

signal pressed
signal unpressed

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	connect("body_entered", self, "_on_player_entered")
	connect("body_exited", self, "_on_player_exited")


func _on_body_entered(body: PhysicsBody2D) -> void:
	if not body is Box:
		return
	animated_sprite.play("Down")
	
	var animation : String
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
	emit_signal("pressed")
	
func _on_body_exited(body: PhysicsBody2D) -> void:
	if not body is Box:
		return
	animated_sprite.play("Up")
	
	var animation : String
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
	emit_signal("unpressed")



func _on_player_entered(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	animated_sprite.play("Down")
	
	var animation : String
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
	emit_signal("pressed")

func _on_player_exited(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	animated_sprite.play("Up")
	
	var animation : String
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)
	emit_signal("unpressed")
