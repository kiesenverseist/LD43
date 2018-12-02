extends Panel

func _ready():
	pass

func _draw():
	#code is ripped from previous project
	#have no idea how it works
	#so dont touch it
	var rec = $"/root/Main".record
	var lim = $"/root/Main".limits
	var col = $"/root/Main".colors
	
	for type in rec:
		var line = []
		
		for i in range(rec[type].size()):
			var vec = Vector2()
			vec.x = rect_size.x / 101 *(100- i)
			vec.y = rect_size.y * (1-rec[type][i] / lim[type])
			line.append(vec)
		
		for i in range(1, line.size()):
			draw_line(line[i-1], line[i], col[type],2)