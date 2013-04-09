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

# Instantiate our head with our nested data
myHead = new HeadModel(myHeadFixture)


# =====================================
# Tests

joe.describe 'backbone-nesty', (describe,it) ->
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


	it 'should instantiate nested data correctly', ->
		expect(
			myHead.toJSON()
		).to.eql(myHeadFixture)


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
		# todo