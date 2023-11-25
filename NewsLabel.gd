extends Label

var default_news = ["Queen is lovely.", "Ants are hungry."]
var news = default_news

func _on_news_timer_timeout():
	text = get_new_text()


func _ready():
	NewsHandler.connect("news", add_news)



func get_new_text():
	var news_num = randi_range(0, news.size()-1)
	if news in default_news and news.size() > 2:
		news_num = randi_range(2, news.size()-1)
	var new_text = news[news_num]
	if new_text == text: return get_new_text()
	else: return new_text


func _on_new_news_timer_timeout():
	news = default_news


func add_news(s: String):
	news.append(s)
