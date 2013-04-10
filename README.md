# Backbone Nesty

[![Build Status](https://secure.travis-ci.org/bevry/backbone-nesty.png?branch=master)](http://travis-ci.org/bevry/backbone-nesty)
[![NPM version](https://badge.fury.io/js/backbone-nesty.png)](https://npmjs.org/package/backbone-nesty)
[![Flattr this project](http://api.flattr.com/button/flattr-badge-large.png)](http://flattr.com/thing/344188/balupton-on-Flattr)

Support nested data types like collections and models within your [Backbone.js](http://backbonejs.org/) [models](http://backbonejs.org/#Model)



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
var Backbone = require('backbone');
var BackboneNestyModel = require('backbone-nesty').BackboneNestyModel;

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
```

### BackboneNestyModel API

`require('backbone-nesty').BackboneNestyModel` is an extended [Backbone.js](http://backbonejs.org/) [Model](http://backbonejs.org/#Model) that adds the following functionality:

- properties
	- `collections` defaults to `{}`, an object which keys are the attributes and values are the collection data type for the attribute
	- `models` defaults to `{}`, an object which keys are the attributes and values are the model data type for the attribute
	- `embed` defaults to `{}`, an object which keys are the attributes and values are boolean on whether or not we should embed the full data of this attribute when calling `toJSON` on the model or just an id listing
	- `strict` defaults to `true`, a boolean for whether or not we should allow unknown attributes to be set on our model
- methods
	- `toJSON()` will serialize the model and all nested data types as well, if the embed property for an nested data type is false, that value will be replaced with an id listing instead
	- `get(key)` adds support for nested gets
	- `set(attrs,opts)` adds support for nested sets and will instantiate the value according to the nested data type if applicable


## History
You can discover the history inside the [History.md](https://github.com/bevry/backbone-nesty/blob/master/History.md#files) file


## Backers
Check out the [Backers.md](https://github.com/bevry/backbone-nesty/blob/master/Backers.md#files) file to discover all the amazing people who financially supported the development of this project.


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright © 2013+ [Bevry Pty Ltd](http://bevry.me)
