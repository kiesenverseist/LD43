extends RichTextLabel

func _ready():
	pass

func _process(d):
	clear()
	
	var res = $"/root/Main".resources
	var rec = $"/root/Main".record
	
	for type in res:
		add_text(str(type) + " " + str(res[type]))
		if rec[type].size() > 2:
			var diff = rec[type][rec[type].size()-1] - rec[type][rec[type].size()-2]
			if diff > 0:
				push_color(Color(0,1,0))
			else:
				push_color(Color(1,0,0))
			add_text("(%s)" % str(diff))
			pop()
		newline()