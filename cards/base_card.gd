extends Resource
class_name card

export var name : String
export(String, MULTILINE) var description
export var id : int
export(int, 1, 3) var tier

export var benifits = {
	description = "",
	instant = {
		human = 0.0,
		research = 0.0,
		money = 0.0
	},
	generation = {
		human = 0.0,
		research = 0.0,
		money = 0.0
	}
}
export var detriments = {
	description = "",
	instant = {
		human = 0.0,
		research = 0.0,
		money = 0.0
	},
	generation = {
		human = 0.0,
		research = 0.0,
		money = 0.0
	}
}