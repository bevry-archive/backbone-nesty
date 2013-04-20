## History

v1.6.0 April 19, 2013
	- Setting a nested ID collections over a pre-set value will now apply properly

v1.5.0 April 19, 2013
	- Correctly handle setting ID indexed collections
	- Added tests for `embeds` property

v1.4.0 April 18, 2013
	- By default when over-writing a model attribute with a new model, we will replace the old model with the new model, rather than copying in the attributes of the new model into the old model
		- This can be turned off by using `replaceModel: false` inside your set options
	- Added `isPreparedValue(key,value)` method

v1.3.0 April 17, 2013
	- Can now set `strict` property by passing it as an option to the constructor
	- We now dereference the `defaults` as well as the `toJSON` output
	- `toJSON` output will now also have the model's id

v1.2.0 April 17, 2013
	- We now dereference the `defaults` property
	- Methods are now bound to the instance

v1.1.0 April 16, 2013
	- If the nested object already exists, we won't over-write it but instead apply the new values to it

v1.0.1 April 10, 2013
	- `toJSON()` will now use `get` on the model instead of our internal `getDeep` on attributes for fetching nested models then serialising them
	- `get` will now set the value if it needed to be prepared

v1.0.0 April 10, 2013
	- Initial working release

v0.1.0 April 8, 2013
	- Initial non-working version