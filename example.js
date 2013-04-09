// Import
var Backbone = require('backbone');
var BackboneNestyModel = require('./').BackboneNestyModel;

// Eye Model
var EyeModel = Backbone.Model.extend({
	attributes: {
		color: null,
		open: false
	}
});

// Eye Collection
var EyeCollection = Backbone.Collection.extend({
	model: EyeModel
});

// Mouth Model
var MouthModel = Backbone.Model.extend({
	attributes: {
		open: false
	}
});

// Head Model
var HeadModel = BackboneNestyModel.extend({
	// Define our nested collections
	collections: {
		eyes: EyeCollection
	},

	// Define our nested models
	models: {
		mouth: MouthModel
	}
});

// Instantiate our head with our nested data
var myHead = new HeadModel({
	// will create a mouth model with this data
	mouth: {
		open: true
	},
	// will create an eyes collection with this data
	eyes: [
		// will create an eye model with this data
		{
			id: 'left',
			color: 'green',
			open: true
		},
		// will create an eye model with this data
		{
			id: 'right',
			color: 'green',
			open: true
		}
	]
});

// Check
console.log(myHead.toJSON());
console.log(myHead.get('eyes.left.open')); // true
// ^ equiv to myHeader.get('eyes').get('left').get('open')

// Nested Setter
myHead.set('eyes.left.open', false);
// ^ equiv to myHeader.get('eyes').get('right').set('open', false)

// Check
console.log(myHead.toJSON());
console.log(myHead.get('eyes.left.open')); // false