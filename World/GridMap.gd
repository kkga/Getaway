extends GridMap

var width = 20
var height = 20


func _ready() -> void:
	randomize()
	clear()
	make_map()


func make_map() -> void:
	for x in width:
		for z in height:
			var cell = randi() % 15
			set_cell_item(x, 0, z, cell)
