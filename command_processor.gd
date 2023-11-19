extends Node

func process_command(input: String) -> String:
	# Check if the command starts with '/'
	if not input.begins_with("/"):
		return "Commands must start with a '/'."

	# Remove the '/' from the input
	input = input.substr(1, input.length() - 1)

	var words = input.split(" ", false)
	if words.size() == 0:
		return "Whatcha talkin' about Willis?!"

	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()

	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()

		_:
			return "Your commands are not recognised! Try again."

func go(second_word: String) -> String:
	if second_word == "":
		return "Where you trying to go?"

	return "You go %s" % second_word

func help() -> String:
	return "The following commands can be used: /go [location]"
