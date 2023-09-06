extends Property

class_name Status
var status_name : String = "Status Effect"
var properties
signal expired

var duration
var current_tick = 1

var unremovable : bool = false #not literally unremovable but maybe until you rest at a bonfire or whatever

func expire():
	emit_signal("expired")
	queue_free()
