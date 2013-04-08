# Backbone Nesty

[![Build Status](https://secure.travis-ci.org/bevry/backbone-nesty.png?branch=master)](http://travis-ci.org/bevry/backbone-nesty)
[![NPM version](https://badge.fury.io/js/backbone-nesty.png)](https://npmjs.org/package/backbone-nesty)

Support nested data types like collections, arrays, and models within your [Backbone.js](http://backbonejs.org/) [Models](http://backbonejs.org/#Model)



## Install

### Backend

1. [Install Node.js](http://bevry.me/node/install)
2. `npm install --save backbone-nesty`

### Frontend

1. [See Browserify](http://browserify.org/)



## Usage

### Example

``` javascript
// Import
var backbone = require('backbone');
var BackboneNestyModel = require('backbone-nesty').BackboneNestyModel;
var models = {};
var collections = {};

// Eye Model
models.Eye = backbone.Model.extend({
	attributes: {
		color: null,
		location: null,  // left or right
		open: false
	}
});

// Eye Collection
collections.Eye = backbone.Collection.extend({
	model: models.Eye
});

// Mouth Model
var Mouth = Backbone.Model.extend({
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
var myHead = new MyModel({

	// will create a mouth model with this data
	mouth: {
		open: true
	},
	
	// will create an eyes collection with this data
	eyes: [
		
		// will create an eye model with this data
		{
			color: 'green',
			location: 'left',
			open: true
		},
		
		// will create an eye model with this data
		{
			color: 'green',
			location: 'right',
			open: true
		}
	]
});

// Nested Getter
console.log(myHead.get('eyes.0.open')); // true
// ^ equiv to myHeader.get('eyes').at(0).get('open')

// Nested Setter
myHead.set('eyes.0.open', false);
// ^ equiv to myHeader.get('eyes').at(0).set('open', false)

// Check
console.log(myHead.get('eyes.0.open')); // false
```

## History
You can discover the history inside the [History.md](https://github.com/bevry/backbone-nesty/blob/master/History.md#files) file


## Backers
Check out the [Backers.md](https://github.com/bevry/backbone-nesty/blob/master/Backers.md#files) file to discover all the amazing people who financially supported the development of this project.


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright © 2013+ [Bevry Pty Ltd](http://bevry.me)
