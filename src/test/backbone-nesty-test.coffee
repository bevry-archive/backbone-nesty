# Import
{expect} = require('chai')
joe = require('joe')
Backbone = require("backbone")
{BackboneNestyModel} = require('../..')


# =====================================
# Fixtures

# Eye Model
EyeModel = Backbone.Model.extend(
	defaults:
		color: null
		open: false
)

# Eye Collection
EyeCollection = Backbone.Collection.extend(
	model: EyeModel
)

# Mouth Model
MouthModel = Backbone.Model.extend(
	defaults:
		open: false
)

# Head Model
HeadModel = BackboneNestyModel.extend(
	collections:
		eyes: EyeCollection

	models:
		mouth: MouthModel
)

# Define our fixture data
myHeadFixture =
	# This attribute doesn't exist, as by default we are strict models, it should be ignored
	notSafeAttribute: true

	# will create a mouth model with this data
	mouth:
		open: true

	# will create an eyes collection with this data
	eyes: [
		# will create an eye model with this data
		id: "left"
		color: "green"
		open: true
	,
		# will create an eye model with this data
		id: "right"
		color: "green"
		open: true
	]


# =====================================
# Tests

joe.describe 'backbone-nesty', (describe,it) ->
	# Prepare
	myHead = null

	it 'should set correctly', ->
		checks = 0
		myHead = new HeadModel().on 'warn', (err) ->
			++checks
			expect(err.message).to.equal("Set of notSafeAttribute ignored on strict model")
		myHead.set(myHeadFixture)
		expect(checks).to.eql(1)

	it 'should instantiate correctly', ->
		myHead = new HeadModel(myHeadFixture)

	describe 'meta functions', (describe,it) ->
		it 'should detect id attribute correctly', ->
			expect(
				myHead.isIdAttribute('id')
			).to.eql(true)
			expect(
				myHead.isIdAttribute('cid')
			).to.eql(true)

		it 'should detect nested attribute correctly', ->
			expect(
				myHead.isNestedAttribute('id')
			).to.eql(false)
			expect(
				myHead.isNestedAttribute('mouth')
			).to.eql('models')
			expect(
				myHead.isNestedAttribute('eyes')
			).to.eql('collections')

	it 'should have instantiated nested data correctly', ->
		actual = myHead.toJSON()
		expect(actual).to.deep.equal(
			mouth: open: true
			eyes: [
				id: "left"
				color: "green"
				open: true
			,
				id: "right"
				color: "green"
				open: true
			]
		)

	describe 'nested models', (describe,it) ->
		it 'should perform getters on nested models correctly', ->
			value = myHead.get("mouth.open")
			expect(value).to.eql(true)

		it 'should perform setters on nested models correctly', ->
			myHead.set("mouth.open", false)
			value = myHead.get("mouth.open")
			expect(value).to.eql(false)

	describe 'nested collections', (describe,it) ->
		it 'should perform getters on nested collections correctly', ->
			value = myHead.get("eyes.left.open")
			expect(value).to.eql(true)

		it 'should perform setters on nested collections correctly', ->
			myHead.set("eyes.left.open", false)
			value = myHead.get("eyes.left.open")
			expect(value).to.eql(false)

	it 'should indicate the changes in the serialization', ->
		actual = myHead.toJSON()
		expect(actual).to.deep.equal(
			mouth: open: false
			eyes: [
				id: "left"
				color: "green"
				open: false
			,
				id: "right"
				color: "green"
				open: true
			]
		)