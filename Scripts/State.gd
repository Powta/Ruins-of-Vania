extends Node
class_name State

signal Transitioned #Anytime you wanna leave the state, you wanna call this signal
func Enter():
	pass

func Exit():
	pass

func Update(_delta:float):
	pass

func Physics_Update(_delta:float):
	pass
