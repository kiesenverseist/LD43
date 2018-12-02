extends Panel

func _ready():
	pass

func _draw():
	#code is ripped from previous project
	#have no idea how it works
	#so dont touch it
	var rec = $"/root/Main".record
	
	for type in rec:
		var m = rec[type].max()
		var line = []
		
		for i in range(rec[type].size()):
			var vec = Vector2()
			vec.x = rect_size.x / 100 * i
			vec.y = rect_size.y * (1-rec[type][i] / max(m,1))
			line.append(vec)
		
		for i in range(1, line.size()):
			draw_line(line[i-1], line[i], Color(1,0,0),2)