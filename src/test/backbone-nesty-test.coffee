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
	defaults:
		safeAttribute: null

	collections:
		eyes: EyeCollection
		toes: Array

	models:
		mouth: MouthModel
)

# Define our fixture data
myHeadFixture =
	# This attribute doesn't exist, as by default we are strict models, it should be ignored
	notSafeAttribute: true
	safeAttribute: true

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

	toes: [1,2,3,4,5,6,7,8,9,10]


# =====================================
# Tests

joe.describe 'backbone-nesty', (describe,it) ->
	# Prepare
	myHead = null

	it 'should set', ->
		checks = 0
		myHead = new HeadModel().on 'warn', (err) ->
			++checks
			expect(err.message).to.equal("Set of notSafeAttribute ignored on strict model")
		myHead.set(myHeadFixture)
		expect(checks).to.eql(1)

	it 'should instantiate', ->
		myHead = new HeadModel(myHeadFixture)

	describe 'meta functions', (describe,it) ->
		it 'should detect id attribute', ->
			expect(
				myHead.isIdAttribute('id')
			).to.eql(true)
			expect(
				myHead.isIdAttribute('cid')
			).to.eql(true)

		it 'should detect nested attribute', ->
			expect(
				myHead.isNestedAttribute('id')
			).to.eql(false)
			expect(
				myHead.isNestedAttribute('mouth')
			).to.eql('models')
			expect(
				myHead.isNestedAttribute('eyes')
			).to.eql('collections')

	it 'should have instantiated nested data', ->
		actual = myHead.toJSON()
		expect(actual).to.deep.equal(
			safeAttribute: true
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
			toes: [1,2,3,4,5,6,7,8,9,10]
		)

	describe 'nested models', (describe,it) ->
		it 'should perform getters on nested models', ->
			value = myHead.get("mouth.open")
			expect(value).to.eql(true)

		it 'should perform setters on nested models', ->
			myHead.set("mouth.open", false)
			value = myHead.get("mouth.open")
			expect(value).to.eql(false)

	describe 'nested collections', (describe,it) ->
		it 'should perform getters on nested collections', ->
			value = myHead.get("eyes.left.open")
			expect(value).to.eql(true)

		it 'should perform setters on nested collections', ->
			myHead.set("eyes.left.open", false)
			value = myHead.get("eyes.left.open")
			expect(value).to.eql(false)

	it 'should indicate the changes in the serialization', ->
		actual = myHead.toJSON()
		expect(actual).to.deep.equal(
			safeAttribute: true
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
			toes: [1,2,3,4,5,6,7,8,9,10]
		)

	describe 'nested events', (describe,it) ->
		it 'should still fire after re-set', ->
			checks = 0
			thirdEye = {id:'third',color:'brown',open:true}

			myHead.get('eyes')
				.on('add', (model) ->
					++checks
					expect(model.toJSON()).to.deep.equal(thirdEye)
				)
				.add(thirdEye)

			myHead.set("eyes",[])
			myHead.get('eyes')
				.add(thirdEye)

			process.nextTick ->
				expect(checks).to.eql(2)