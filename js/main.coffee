# jQuery is included in the page HTML
_ = require('lodash')
keymage = require('keymage')

jQuery ($) ->
	# game data
	
	tiles =
		circle: {filename: "circle.gif", alt: "circle", chars: ["o", "○"]}
		solidBlock: {filename: "solid-block.gif", alt: "solid block", chars: ["X", "⛝"]}
	menuButtons =
		allSelector: '.menu-button'
		play: {selector: ".play-button"}
		help: {selector: ".help-button"}
		exit: {selector: ".exit-button"}
	levelGrid =
		selector: '.level-grid'
	messages =
		allSelector: '.message'
		title: {selector: ".dont-match-message"}
		help: {selector: ".you-fell-message"}
		level: {selector: ".beat-level-message"}
	
	levelStrings = require('./level-data')
	
	displayData =
		nativeResolution:
			width: 96
			height: 64
		scaleFactor: 2
	
	
	# some functions
	
	# …
	
	
	# game state
	
	currentScreen = undefined
	
	
	# more functions
	
	constrainToRange = (value, min, max) ->
		return switch
			when value < min then min
			when value > max then max
			else value
	
	# register input handlers
	
	keys =
		up: ['up']
		down: ['down']
		left: ['left']
		right: ['right']
		confirm: ['enter', 'space']
		reset: ['r']
		exit: ['esc']
		nextLevel: ['plus']
		previousLevel: ['minus']
	
	registerKey = (control, handler) ->
		keymage(control, handler, {preventDefault: true})
	
	_(keys).each (controls, eventName) ->
		runInputHandlerIfExists = (event) ->
			currentScreen.inputHandlers?[eventName]?(event)
		_(controls).each (control) ->
			registerKey control, runInputHandlerIfExists
	
	
	# start the game
	
	# …
