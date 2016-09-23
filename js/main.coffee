# jQuery is included in the page HTML
_ = require('lodash')
keymage = require('keymage')

jQuery ($) ->
	# game state
	# initialized in startNewGame
	gameState =
		currentPlayer: null
		grid: null
	
	
	# game data
	
	numRows = 6
	numCols = 7
	playerTexts =
		playerX: "X"
		playerO: "O"
	messageTexts =
		playerTurn: (playerText) -> "#{playerText}’s turn"
		playerWins: (playerText) -> "#{playerText} wins!"
	
	inputHandlers =
		col1: -> handleColButton(1)
		col2: -> handleColButton(2)
		col3: -> handleColButton(3)
		col4: -> handleColButton(4)
		col5: -> handleColButton(5)
		col6: -> handleColButton(6)
		col7: -> handleColButton(7)
		newGame: startNewGame
	
	
	# other functions
	
	startNewGame = ->
		gameState.currentPlayer = 1
		gameState.grid = makeEmptyGrid()
		console.log("gameState", gameState)
		refreshUI()
	
	handleColButton = (col) ->
		if colHasSpace(col)
			dropPieceInCol(col)
		refreshUI()
	
	colHasSpace = (col) ->
		true # TODO
	
	dropPieceInCol = (col) ->
		undefined # TODO
	
	refreshUI = ->
		refreshGridDisplay()
		refreshMessage()
	
	# grid functions
	
	makeEmptyGrid = ->
		rows = []
		for row in [1..numRows]
			rowArray = []
			for col in [1..numCols]
				rowArray.push(0)
			rows.push(rowArray)
		rows
	
	gridValueToText = (value) ->
		switch value
			when 0 then " "
			when 1 then "X"
			when -1 then "O"
			else "err: #{value}"
	
	redisplayGridColRow = (col, row, value) ->
		$tableCell = $(".board-grid .x#{col}-y#{row}")
		displayValue = gridValueToText(value)
		$tableCell.text(displayValue)
	
	refreshGridDisplay = ->
		for col in [1..numCols]
			for row in [1..numRows]
				value = getGridColRow(col, row)
				redisplayGridColRow(col, row, value)
	
	getGridColRow = (col, row) ->
		gameState.grid[row-1][col-1]
	setGridColRow = (col, row, value) ->
		gameState.grid[row-1][col-1] = value
	
	switchCurrentPlayer = ->
		gameState.currentPlayer *= -1
	
		# message functions
	
	messageForGameState = (gameState) ->
		player = gameState.currentPlayer
		playerText = switch player
			when 1 then playerTexts.playerX
			when -1 then playerTexts.playerY
		return messageTexts.playerTurn(playerText)
	
	refreshMessage = ->
		message = messageForGameState(gameState)
		$('.message').text(message)
	
	
	# more functions
	
	constrainToRange = (value, min, max) ->
		return switch
			when value < min then min
			when value > max then max
			else value
	
	# register input handlers
	
	keys =
		col1: ['1']
		col2: ['2']
		col3: ['3']
		col4: ['4']
		col5: ['5']
		col6: ['6']
		col7: ['7']
		newGame: ['n']
	
	registerKey = (control, handler) ->
		keymage(control, handler, {preventDefault: true})
	
	# commenting out keybindings because I get an error and don’t have time to debug it
	#_(keys).each (controls, eventName) ->
	#	_(controls).each (control) ->
	#		registerKey control, inputHandlers[eventName]
	
	
	# start the game
	
	startNewGame()
