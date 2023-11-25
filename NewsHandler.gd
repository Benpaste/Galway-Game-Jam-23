extends Node

signal news(s: String)
func broadcast(s: String):
	news.emit(s)
