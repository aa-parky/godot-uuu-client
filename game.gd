extends Control

const Response = preload("res://response.tscn")
const InputResponse = preload("res://input_response.tscn")

@export var max_lines_remembered := 30

@onready var command_processor = $command_processor

@onready var history_rows = $background / MarginContainer / Rows / game_info / ScrollContainer / history_rows
@onready var scroll = $background / MarginContainer / Rows / game_info / ScrollContainer
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready():
	scrollbar.connect("changed", handle_scrollbar_changed)
	var starting_message = Response.instantiate()
	starting_message.text = "The Undermine Undertakers, a guild of the extraordinary, are calling for those with a hunger for the unknown and a flair for the dramatic. Snappy Flashsnap, Lensflare Lizzik, and their band of intrepid photographers are just a glimpse of the vibrant tapestry that awaits. Capture the essence of Azeroth's events and characters, bring stories to life with a click and a flash, and etch your name in the annals of the Undermine. Unveil the mysteries. Write the stories yet untold. The adventure of a lifetime awaits in the Undermine. The question is, are you ready to capture it?"
	add_initial_startup_message(starting_message)


func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value


func _on_input_text_submitted(new_text):
	if new_text.is_empty():
		return

	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	add_initial_startup_message(input_response)


func add_initial_startup_message(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()


func delete_history_beyond_limit():
		if history_rows.get_child_count() > max_lines_remembered:
			var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
			for i in range(rows_to_forget):
				history_rows.get_child(i).queue_free()
