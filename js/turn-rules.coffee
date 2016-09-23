Immutable = require('immutable')

gameStateAfterInput = (gameState, input) ->
	nextState = gameState.setIn()
	gameState.levelTiles
	gameState.playerCoords
	gameState.currentMessage
