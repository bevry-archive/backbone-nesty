## History

v1.0.1 April 10, 2013
	- `toJSON()` will now use `get` on the model instead of our internal `getDeep` on attributes for fetching nested models then serialising them
	- `get` will now set the value if it needed to be prepared

v1.0.0 April 10, 2013
	- Initial working release

v0.1.0 April 8, 2013
	- Initial non-working version