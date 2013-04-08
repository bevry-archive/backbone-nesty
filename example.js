// Import
var backbone = require('backbone');
var BackboneNestyModel = require('./').BackboneNestyModel;
var models = {};
var collections = {};

// Eye Model
models.Eye = backbone.Model.extend({
	attributes: {
		color: null,
		open: false
	}
});

// Eye Collection
collections.Eye = backbone.Collection.extend({
	model: models.Eye
});

// Mouth Model
models.Mouth = backbone.Model.extend({
	attributes: {
		open: false
	}
});

// Head Model
models.Head = BackboneNestyModel.extend({
	// Define our nested collections
	collections: {
		eyes: collections.Eye
	},

	// Define our nested models
	models: {
		mouth: models.Mouth
	}
});

// Instantiate our head with our nested data
var myHead = new models.Head({
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