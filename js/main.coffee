# jQuery is included in the page HTML
_ = require('lodash')
keymage = require('keymage')

jQuery ($) ->
	# game state
	# initialized in startNewGame
	gameState =
		currentPlayer: null
		grid: null
		winner: null
	
	
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
		console.log("handling col button", col)
		if colHasSpace(col)
			dropPieceInCol(col)
		
		winner = winningPlayer()
		if winner == null
			switchCurrentPlayer()
		else
			console.log("winner detected", winner)
			gameState.winner = winner
		
		refreshUI()
		console.log(gameState)
	
	colHasSpace = (col) ->
		true
		# lowestEmptyRowInCol() != null
	
	dropPieceInCol = (col) ->
		row = lowestEmptyRowInCol(col)
		playerNum = gameState.currentPlayer
		setGridColRow(col, row, playerNum)
		console.log("setGridColRow", col, row, playerNum)
	
	lowestEmptyRowInCol = (col) ->
		# returns null if no empty row, otherwise that row number
		for row in [numRows..1]
			if getGridColRow(col, row) == 0
				return row
		return null
	
	winningPlayer = () ->
		# returns null if no winner, or 1 or -1 if that player won
		coordGroupsToSearch = []
		# search horizontally
		[1..numRows].forEach (row) ->
			[1..(numCols-3)].map (col) ->
				fourPairsOfCoords = [0...4].map (colOffset) ->
					[col+colOffset, row]
				coordGroupsToSearch.push fourPairsOfCoords
		# search down and to the right
		[1..(numRows-3)].forEach (row) ->
			[1..(numCols-3)].map (col) ->
				fourPairsOfCoords = [0...4].map (offset) ->
					[col+offset, row+offset]
				coordGroupsToSearch.push fourPairsOfCoords
		# search vertically
		[1..(numRows-3)].forEach (row) ->
			[1..numCols].map (col) ->
				fourPairsOfCoords = [0...4].map (rowOffset) ->
					[col, row+rowOffset]
				coordGroupsToSearch.push fourPairsOfCoords
		# search down and to the left
		[1..(numRows-3)].forEach (row) ->
			[(1+3)..numCols].map (col) ->
				fourPairsOfCoords = [0...4].map (offset) ->
					[col-offset, row+offset]
				coordGroupsToSearch.push fourPairsOfCoords
		
		for fourCoords in coordGroupsToSearch
			gridValuesInGroup = fourCoords.map ([col, row]) ->
				getGridColRow(col, row)
			console.log "gridValuesInGroup", gridValuesInGroup
			if allEqual(gridValuesInGroup)
				sharedValue = gridValuesInGroup[0]
				if sharedValue != 0
					playerNum = sharedValue
					return playerNum
		
		return null
	
	refreshUI = ->
		refreshGridDisplay()
		refreshMessage()
	
	allEqual = (values) ->
		if values.length == 0
			return true
		else
			[first, rest] = [values[0], values[1..]]
			return _.every(rest, (val) -> val == first)
	
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
	
	playerText = (playerNum) ->
		switch playerNum
			when 1 then playerTexts.playerX
			when -1 then playerTexts.playerO
			else "error"
	
	messageForGameState = (gameState) ->
		text = undefined
		if gameState.winner == null
			player = gameState.currentPlayer
			text = playerText(player)
			return messageTexts.playerTurn(text)
		else
			player = gameState.winner
			text = playerText(player)
			return messageTexts.playerWins(text)
	
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
	
	# register column buttons
	for col in [1..numCols]
		$colButton = $(".board-grid .buttons .col#{col}")
		$colButton.on('click', inputHandlers["col#{col}"])
	
	# register New Game button
	$('.menu-buttons .new-game').on('click', startNewGame)
	
	# commenting out keybindings because I get an error and don’t have time to debug it
	#_(keys).each (controls, eventName) ->
	#	_(controls).each (control) ->
	#		registerKey control, inputHandlers[eventName]
	
	
	# start the game
	
	startNewGame()
