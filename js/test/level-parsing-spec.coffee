expect = require('chai').expect

#levelParsing = require('../level-parsing')
#{parseLevel, TileTypes} = levelParsing

describe "the test runner", ->
	it "works", ->
		input = "abc"
		expected = "abcd"
		expect( input+"d" ).to.eql(expected)
