## History

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