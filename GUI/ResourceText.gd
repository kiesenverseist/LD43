extends RichTextLabel

func _ready():
	pass

func _process(d):
	clear()
	
	var res = $"/root/Main".resources
	var rec = $"/root/Main".record
	var col = $"/root/Main".colors
	var lim = $"/root/Main".limits
	
	for type in res:
		
		push_color(col[type])
		add_text(str(type) + " :")
		pop()
		
		add_text(str(round(res[type])) + "/" + str(round(lim[type])))
		
		if rec[type].size() > 2:
			var diff = rec[type][0] - rec[type][1]
			
			if diff > 0:
				push_color(Color(0,1,0))
			elif diff < 0:
				push_color(Color(1,0,0))
			
			add_text(" (%s)" % str(float(round(diff*10))/10))
			
			if diff != 0: pop()
		
		newline()