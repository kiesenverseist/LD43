extends ProgressBar

func _ready():
	pass

func _process(delta):
	max_value = $"/root/Main".research_goal
	value = $"/root/Main".resources.research