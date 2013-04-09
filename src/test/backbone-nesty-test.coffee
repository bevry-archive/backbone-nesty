# Import
{expect} = require('chai')
joe = require('joe')
Backbone = require("backbone")
{BackboneNestyModel} = require('../..')


# =====================================
# Fixtures

# Eye Model
EyeModel = Backbone.Model.extend(attributes:
	color: null
	open: false
)

# Eye Collection
EyeCollection = Backbone.Collection.extend(model: EyeModel)

# Mouth Model
MouthModel = Backbone.Model.extend(attributes:
	open: false
)

# Head Model
HeadModel = BackboneNestyModel.extend(

	# Define our nested collections
	collections:
		eyes: EyeCollection


	# Define our nested models
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
	it 'should instantiate nested data correctly', ->
		expect(myHead.toJSON()).to.eql(myHeadFixture)

	it 'should perform nested getters correctly', ->
		value = myHead.get("eyes.left.open")
		console.log myHead.get('eyes').get('left').get('open')
		expect(value).to.eql(true)

	it 'should perform nested setters correctly', ->
		myHead.set("eyes.left.open", false)
		value = myHead.get("eyes.left.open")
		expect(value).to.eql(false)

	it 'should indicate the changes in the serialization', ->
		# todo