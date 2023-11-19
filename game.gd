extends Control


const InputResponse = preload("res://input_response.tscn")

@onready var history_rows = $background/MarginContainer/Rows/game_info/ScrollContainer/history_rows
@onready var scroll = $background/MarginContainer/Rows/game_info/ScrollContainer
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready():
	scrollbar.connect("changed", handle_scrollbar_changed)
	
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value


func _on_input_text_submitted(new_text):
	if new_text.is_empty():
		return
		
	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, "Server says...hmmm...")
	history_rows.add_child(input_response)
