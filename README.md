<!-- TITLE/ -->

<h1>Backbone Nesty</h1>

<!-- /TITLE -->


<!-- BADGES/ -->

<span class="badge-travisci"><a href="http://travis-ci.org/bevry/backbone-nesty" title="Check this project's build status on TravisCI"><img src="https://img.shields.io/travis/bevry/backbone-nesty/master.svg" alt="Travis CI Build Status" /></a></span>
<span class="badge-npmversion"><a href="https://npmjs.org/package/backbone-nesty" title="View this project on NPM"><img src="https://img.shields.io/npm/v/backbone-nesty.svg" alt="NPM version" /></a></span>
<span class="badge-npmdownloads"><a href="https://npmjs.org/package/backbone-nesty" title="View this project on NPM"><img src="https://img.shields.io/npm/dm/backbone-nesty.svg" alt="NPM downloads" /></a></span>
<span class="badge-daviddm"><a href="https://david-dm.org/bevry/backbone-nesty" title="View the status of this project's dependencies on DavidDM"><img src="https://img.shields.io/david/bevry/backbone-nesty.svg" alt="Dependency Status" /></a></span>
<span class="badge-daviddmdev"><a href="https://david-dm.org/bevry/backbone-nesty#info=devDependencies" title="View the status of this project's development dependencies on DavidDM"><img src="https://img.shields.io/david/dev/bevry/backbone-nesty.svg" alt="Dev Dependency Status" /></a></span>
<br class="badge-separator" />
<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-gratipay"><a href="https://www.gratipay.com/bevry" title="Donate weekly to this project using Gratipay"><img src="https://img.shields.io/badge/gratipay-donate-yellow.svg" alt="Gratipay donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-bitcoin"><a href="https://bevry.me/bitcoin" title="Donate once-off to this project using Bitcoin"><img src="https://img.shields.io/badge/bitcoin-donate-yellow.svg" alt="Bitcoin donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>
<br class="badge-separator" />
<span class="badge-slackin"><a href="https://slack.bevry.me" title="Join this project's slack community"><img src="https://slack.bevry.me/badge.svg" alt="Slack community badge" /></a></span>

<!-- /BADGES -->


<!-- DESCRIPTION/ -->

Support nested data types like collections and models within your Backbone.js models

<!-- /DESCRIPTION -->


<!-- INSTALL/ -->

<h2>Install</h2>

<a href="https://npmjs.com" title="npm is a package manager for javascript"><h3>NPM</h3></a><ul>
<li>Install: <code>npm install --save backbone-nesty</code></li>
<li>Module: <code>require('backbone-nesty')</code></li></ul>

<a href="http://browserify.org" title="Browserify lets you require('modules') in the browser by bundling up all of your dependencies"><h3>Browserify</h3></a><ul>
<li>Install: <code>npm install --save backbone-nesty</code></li>
<li>Module: <code>require('backbone-nesty')</code></li>
<li>CDN URL: <code>//wzrd.in/bundle/backbone-nesty@2.0.0</code></li></ul>

<a href="http://enderjs.com" title="Ender is a full featured package manager for your browser"><h3>Ender</h3></a><ul>
<li>Install: <code>ender add backbone-nesty</code></li>
<li>Module: <code>require('backbone-nesty')</code></li></ul>

<h3><a href="https://github.com/bevry/editions" title="Editions are the best way to produce and consume packages you care about.">Editions</a></h3>

<p>This package is published with the following editions:</p>

<ul><li><code>backbone-nesty</code> aliases <code>backbone-nesty/index.js</code> which uses <a href="https://github.com/bevry/editions" title="Editions are the best way to produce and consume packages you care about.">Editions</a> to automatically select the correct edition for the consumers environment</li>
<li><code>backbone-nesty/source/index.coffee</code> is Source + CoffeeScript + <a href="https://nodejs.org/dist/latest-v5.x/docs/api/modules.html" title="Node/CJS Modules">Require</a></li>
<li><code>backbone-nesty/esnext/index.js</code> is CoffeeScript Compiled + <a href="https://babeljs.io/docs/learn-es2015/" title="ECMAScript Next">ESNext</a> + <a href="https://nodejs.org/dist/latest-v5.x/docs/api/modules.html" title="Node/CJS Modules">Require</a></li>
<li><code>backbone-nesty/es2015/index.js</code> is CoffeeScript Compiled + <a href="http://babeljs.io/docs/plugins/preset-es2015/" title="ECMAScript 2015">ES2015</a> + <a href="https://nodejs.org/dist/latest-v5.x/docs/api/modules.html" title="Node/CJS Modules">Require</a></li></ul>

<p>Older environments may need <a href="https://babeljs.io/docs/usage/polyfill/" title="A polyfill that emulates missing ECMAScript environment features">Babel's Polyfill</a> or something similar.</p>

<!-- /INSTALL -->


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

<!-- HISTORY/ -->

<h2>History</h2>

<a href="https://github.com/bevry/backbone-nesty/blob/master/HISTORY.md#files">Discover the release history by heading on over to the <code>HISTORY.md</code> file.</a>

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

<h2>Contribute</h2>

<a href="https://github.com/bevry/backbone-nesty/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

<h2>Backers</h2>

<h3>Maintainers</h3>

These amazing people are maintaining this project:

<ul><li><a href="http://balupton.com">Benjamin Lupton</a> — <a href="https://github.com/bevry/backbone-nesty/commits?author=balupton" title="View the GitHub contributions of Benjamin Lupton on repository bevry/backbone-nesty">view contributions</a></li></ul>

<h3>Sponsors</h3>

These amazing people have contributed finances to this project:

<ul><li><a href="http://www.govests.com.au">GoVests</a></li></ul>

Become a sponsor!

<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-gratipay"><a href="https://www.gratipay.com/bevry" title="Donate weekly to this project using Gratipay"><img src="https://img.shields.io/badge/gratipay-donate-yellow.svg" alt="Gratipay donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-bitcoin"><a href="https://bevry.me/bitcoin" title="Donate once-off to this project using Bitcoin"><img src="https://img.shields.io/badge/bitcoin-donate-yellow.svg" alt="Bitcoin donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>

<h3>Contributors</h3>

These amazing people have contributed code to this project:

<ul><li><a href="http://balupton.com">Benjamin Lupton</a> — <a href="https://github.com/bevry/backbone-nesty/commits?author=balupton" title="View the GitHub contributions of Benjamin Lupton on repository bevry/backbone-nesty">view contributions</a></li></ul>

<a href="https://github.com/bevry/backbone-nesty/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /BACKERS -->


<!-- LICENSE/ -->

<h2>License</h2>

Unless stated otherwise all works are:

<ul><li>Copyright &copy; <a href="http://bevry.me">Bevry Pty Ltd</a></li></ul>

and licensed under:

<ul><li><a href="http://spdx.org/licenses/MIT.html">MIT License</a></li></ul>

<!-- /LICENSE -->
