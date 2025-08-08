@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type(
		"FDIntro",
		"Node",
		preload("res://addons/fire_droid_intro/scripts/fd_intro.gd"),
		preload("res://addons/fire_droid_intro/icons/FDIntro.svg")
	)


func _exit_tree() -> void:
	remove_custom_type("FDIntro")
