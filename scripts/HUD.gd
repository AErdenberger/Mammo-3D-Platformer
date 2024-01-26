extends CanvasLayer

func _on_coin_collected(coins):
	$CoinCounter.text = str(coins)

